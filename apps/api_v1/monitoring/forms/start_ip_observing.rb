# frozen_string_literal: true

class ApiV1
  class Monitoring
    module Forms
      class StartIpObserving < LunaPark::Forms::Simple
        include LunaPark::Extensions::Validatable::Dry

        validator do
          params do
            required(:data).hash do
              required(:type) { eql? 'ip_addresses' }
              required(:attributes).hash do
                required(:ip) { filled? & str? & format?(::Monitoring::Constants::IP_REGEX) }
              end
            end
          end
        end

        def perform(valid_params)
          attributes = valid_params[:data][:attributes]

          { ip: attributes[:ip] }
        end
      end
    end
  end
end
