require 'execjs'

module Rql
  class Parser
    JS_PARSER_PATH = File.join(File.dirname(__FILE__), 'parser.js')

    # Reads the source for the Javascript RQL parser.
    # @api private
    def self.source
      @source ||= open(JS_PARSER_PATH, "r") do |f|
        f.read
      end
    end

    # Initializes an Rql Parser using the specified ExecJS runtime.
    # If no runtime is specified, the best avaiable runtime will be
    # used.
    #
    # @param [ExecJS::Runtime] runtime javascript runtime to use for parsing
    def initialize(runtime=nil)
      runtime ||= ExecJS.runtime
      @context = runtime.compile(self.class.source)
    end

    # Parses an Rql query string, returning a parse tree
    # @param [String] string an rql query string
    # @return [Hash] rql parse tree
    def parseQuery(string)
      @context.call("exports.parseQuery", string)
    end
  end
end
