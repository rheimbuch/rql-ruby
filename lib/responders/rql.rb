module Responders
  module RqlResponder
    def resources
      all_resources = super
      rql = request.env['rql.query']
      if(rql)
        begin
          rql.on(all_resources)
        rescue => e
          controller.logger.error(e)
          all_resources
        end
      else
        all_resources
      end
    end
  end
end
