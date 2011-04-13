module Rql
  class Query
    # Registers a Query evaluator to handle query execution against
    # targets of the specified type.
    #
    # @param [Class] type the object type handled by the evaluator
    # @param [Rql::Evaluator::Base] evaluator the query evaluator class
    def self.register(type, evaluator)
      @evaluators ||= {}
      @evaluators[type] = evaluator
    end

    # Gets a Query Evaluator for a particular type of target
    #
    # @param [Class] type the class to get a Query Evaluator for
    # @param [Class,nil] the Query Evaluator class, or nil if not found
    def self.evaluator_for(type)
      @evaluators ||= {}
      type = type.is_a?(Class) ? type : type.class
      type.ancestors.map{|ancestor| @evaluators[ancestor]}.compact.first
    end

    
    def initialize(name, args)
      @name = name.to_s
      @args = args.map do |arg|
        if arg.kind_of? Hash
          sub_query = self.class.new(arg["name"], arg["args"])
          sub_query
        else
          arg
        end
      end
    end

    # The name of the Rql query operation at the root of this query.
    #
    # @return [Symbol]
    def name
      @name.to_sym
    end
    
    attr_reader :args
    
    def clone
      self.class.new(@name, @args)
    end

    # Run this Query against the target data.
    # If no evaluator is specified, the Query will attempt to
    # autodetect an evaluator based on the type of the target data.
    #
    # @param target the data to be queried
    # @param [Class] evaluator optional evaluator for the query
    # @return the result of the query
    def call(target, evaluator=nil)
      evaluator ||= self.class.evaluator_for(target)
      evaluator = evaluator.is_a?(Class) ? evaluator.new(target) : evaluator
      raise EvaluatorForTypeNotFound unless evaluator
      
      called_args = @args.map do |arg|
        arg.respond_to?(:call) ? arg.call(target, evaluator) : arg
      end
      
      evaluator.public_send(name, *called_args)
    end

    alias_method :[], :call
    alias_method :on, :call

    def trace(target)
      call(target, EchoSexpEvaluator)
    end

    
    class EvaluatorForTypeNotFound < StandardError; end
    
    protected
    
    
    private
    # @api private
    class EchoSexpEvaluator
      def initialize(target)
      end
      
      def method_missing(method, *args, &block)
        [method] + args
      end
    end
  end
end
