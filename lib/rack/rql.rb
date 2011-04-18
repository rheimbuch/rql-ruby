require 'rql'
require 'rack/request'

module Rack
  class RqlQuery
    def initialize(app, js_runtime=nil)
      @app = app
    end

    def call(env)
      req = Rack::Request.new(env)
      qs = req.query_string
      
      req.logger.debug("QUERY_STRING: #{qs}")

      begin
        env['rql.query'] = Rql[qs]
      rescue => e
        env['rql.error'] = e
      end
      
      @app.call(env)
    end
  end
end
