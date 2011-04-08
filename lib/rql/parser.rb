require 'execjs'

module Rql
  class Parser
    JS_PARSER_PATH = File.join(File.dirname(__FILE__), 'parser.js')
    
    def self.source
      @source ||= open(JS_PARSER_PATH, "r") do |f|
        f.read
      end
    end

    def initialize(runtime=nil)
      runtime ||= ExecJS.runtime
      @context = runtime.compile(self.class.source)
    end
    
    def parseQuery(string)
      @context.call("exports.parseQuery", string)
    end
  end
end
