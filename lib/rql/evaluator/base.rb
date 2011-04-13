module Rql
  module Evaluator

    # Base mixin for RQL query evaluators. Implementations of
    # RQL evaluators *MAY* implement more or less of the methods in
    # this module.
    module Base
      attr_reader :target
      
      def initialize(target)
        @target = target
      end

      def and(*results)
        raise NotImplementedError
      end

      def or(*results)
        raise NotImplementedError
      end

      def eq(property, value)
        raise NotImplementedError
      end

      def ne(property, value)
        raise NotImplementedError
      end

      def gt(property, value)
        raise NotImplementedError
      end

      def ge(property, value)
        raise NotImplementedError
      end

      def lt(property, value)
        raise NotImplementedError
      end

      def le(property, value)
        raise NotImplementedError
      end

      def in(property, value)
        raise NotImplementedError
      end

      def distinct(results=target)
        raise NotImplementedError
      end

      def first(results=target)
        raise NotImplementedError
      end

      def count(results=target)
        raise NotImplementedError
      end

      def limit(count, start, results=target)
        raise NotImplementedError
      end
    end
  end
end
