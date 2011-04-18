module Responders
  module RqlResponder
    def resource
      resources.last
    end
    
    def resources
      all_resources = super
      rql = request.env['rql.query']
      controller.logger.debug("RQL Query: #{rql.inspect}")
      if(rql)
        begin
          rql.on(all_resources)
        end
      else
        all_resources
      end
    end
  end
end
