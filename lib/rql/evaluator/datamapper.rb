require 'rql/query'
require 'rql/evaluator/base'
require 'dm-core'

module Rql
  module Evaluator
    class DataMapper
      include Evaluator::Base
      
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

      def sort(*args)
        orders = args.map{|s| parse_sort(s)}.compact
        target.all(:order => orders)
      end

      private
      def parse_sort(str)
        match = str.match(/([+-])(\w+)/)
        if(match)
          dir = match[1]
          field = match[2].to_s.to_sym
          if dir == "-"
            field = field.desc
          else
            field = field.asc
          end
          
          field
        end
      end
    end

    Query.register(::DataMapper::Collection, Evaluator::DataMapper)
    Query.register(::DataMapper::Resource, Evaluator::DataMapper)
  end
end
