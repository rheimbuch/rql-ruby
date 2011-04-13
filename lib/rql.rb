require 'rql/parser'
require 'rql/query'
require 'rql/evaluator/enumerable'

module Rql
  # Returns the ExecJS runtime used by the Rql parser
  #
  # @return [ExecJS::Runtime] Current ExecJS runtime
  def self.runtime
    @runtime ||= ExecJS.runtime
  end

  # Set the ExecJS runtime used by the Rql parser
  #
  # @param [ExecJS::Runtime] runtime ExecJS runtime to use
  def self.runtime=(runtime)
    @runtime = runtime
  end

  # Parse an RQL query string, returning a parse tree.
  # rql_string => parse_tree mapping will be cached. See #clear_cache
  # to discard cached parse_trees.
  #
  # @param [String] rql_string the RQL query string to parse
  # @param [ExecJS::Runtime] js_runtime optional runtime to use for parsing
  # @return [Hash] root of RQL query tree
  def self.parse(rql_string, js_runtime=runtime)
    @parsed_queries ||= {}
    @parsed_queries[rql_string] ||= begin
                                      parser = Rql::Parser.new(js_runtime)
                                      parser.parseQuery(rql_string)
                                    end
  end

  # Parse an RQL query string, returning a Rql::Query object
  #
  # @param [String] rql_string the RQL query string
  # @param [ExecJS::Runtime] js_runtime optional runtime to use for
  #                          parsing
  # @return [Rql::Query] query object for the Rql query string
  #
  # @example
  #   Rql.query("id=5")
  
  def self.query(rql_string, js_runtime=runtime)
    parsed = parse(rql_string, js_runtime)
    Rql::Query.new(parsed['name'], parsed['args'])
  end

  # Clears cached parse trees.
  def self.clear_cache
    @parsed_queries.clear
  end

  # Alias for Rql.query.
  # @see #query
  def self.[](rql_string)
    query(rql_string)
  end
end
