# frozen_string_literal: true

class ApiV1
  class Base < Sinatra::Base
    set :show_exceptions, false
    set :raise_errors, true

    error Common::Errors::NotFound do
      status 404
      JSONAPI::Serializer.serialize_errors('not found').to_json
    end

    error Exception do |e|
      Notifier.error(e)

      status 500
    end
  end
end
