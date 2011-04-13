require 'rql/query'
require 'rql/evaluator/base'


module Rql
  module Evaluator
    
    # Evaluates RQL queries against Enumerable collection types
    # (Array, etc...)
    #
    # @example
    #  data = [ {"id" => 1, "age" => 21},
    #           {"id" => 2, "age" => 26} ]
    #
    #  Rql["age=gt=25"].on(data)
    #  #=> [{"id" => 2, "age" => 26}]
    class Enumerable
      include Evaluator::Base
      
      def get(item, property)
        if(item.respond_to? property.to_sym)
          item.public_send(property.to_sym)
        elsif(item.respond_to? :[])
          item[property.to_s] || item[property.to_sym]
        end
      end

      private :get
      
      def and(*results)
        results.reduce(:&)
      end

      def or(*results)
        results.reduce(:|)
      end

      def eq(property, value)
        target.select{|i| get(i, property) == value}
      end

      def ne(property, value)
        target.select{|i| get(i, property) != value}
      end

      def gt(property, value)
        target.select{|i| get(i, property) > value}
      end

      def ge(property, value)
        target.select{|i| get(i, property) >= value}
      end

      def lt(property, value)
        target.select{|i| get(i, property) < value}
      end

      def le(property, value)
        target.select{|i| get(i, property) <= value}
      end

      def in(property, values)
        target.select{|i| Array(values).include? get(i, property)}
      end

      def distinct(results=target)
        results.uniq
      end

      def first(results=target)
        [results.first]
      end

      def count(results=target)
        [results.size]
      end

      def limit(count, start=0, results=target)
        results[start, count]
      end
    end
  end

  Query.register(Enumerable, Evaluator::Enumerable)
end
