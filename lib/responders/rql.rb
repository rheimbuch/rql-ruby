module Responders
  module RqlResponder
    def resource
      super_resource = super
      rql = request.env['rql.query']
      controller.logger.debug("RQL Query: #{rql.inspect}")
      if(rql)
        begin
          rql.on(super_resource)
        end
      else
        super_resource
      end
    end
  end
end
