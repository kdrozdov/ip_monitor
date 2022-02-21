# frozen_string_literal: true

class ApiV1
  class Monitoring < Base
    helpers Http::Helpers::Common

    include ::Monitoring

    post '/ip_addresses', provides: :json do
      handle do
        valid_params = submit! Forms::StartIpObserving.new(params)
        result = perform! Scenarios::StartIpObserving.call(valid_params)

        Serializers::IpAddress.serialize(result.data).to_json
      end
    end

    delete '/ip_addresses/:ip', provides: :json do
      handle do
        result = perform! Scenarios::StopIpObserving.call(ip: params[:ip])

        Serializers::IpAddress.serialize(result.data).to_json
      end
    end

    get '/ip_reports/:ip', provides: :json do
      handle do
        result = perform! Scenarios::BuildIpReport.call(
          ip: params[:ip],
          from: Time.parse(params[:from]),
          to: Time.parse(params[:to])
        )

        Serializers::IpReport.serialize(result.data).to_json
      end
    end
  end
end
