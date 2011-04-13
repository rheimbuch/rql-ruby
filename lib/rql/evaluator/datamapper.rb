require 'rql/query'
require 'rql/evaluator/base'

module Rql
  module Evaluator
    class DataMapper
      def and(*results)
        results.reduce(:&)
      end

      def or(*results)
        results.reduce(:|)
      end
      
      def eq(property, value)
        property = property.to_sym
        target.all(property => value)
      end

      def ne(property, value)
        property = property.to_sym
        target.all(property.not => value)
      end

      def gt(property, value)
        property = property.to_sym
        target.all(property.gt => value)
      end

      def ge(property, value)
        property = property.to_sym
        target.all(property.gte => value)
      end

      def lt(property, value)
        property = property.to_sym
        target.all(property.lt => value)
      end

      def le(property, value)
        property = property.to_sym
        target.all(property.lte => value)
      end

      def first(results=target)
        results.first
      end

      def count(results=target)
        results.count
      end

      def limit(count, start=0, results=target)
        results.all(:limit => count, :offset => start)
      end
    end
  end
end
