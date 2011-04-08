require 'rql/parser'

module Rack
  class RqlQuery
    def initialize(app, js_runtime=nil)
      @app = app
      @parser = Rql::Parser.new(js_runtime)
    end

    def call(env)
      if !env['rql.query'] && env['QUERY_STRING']
        begin
          env['rql.query'] = @parser.parseQuery(env['QUERY_STRING'])
        rescue => e
          env['rql.error'] = e
        end
      end
      
      @app.call(env)
    end
  end
end
