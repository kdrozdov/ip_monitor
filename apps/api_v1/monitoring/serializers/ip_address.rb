# frozen_string_literal: true

class ApiV1
  class Monitoring
    module Serializers
      class IpAddress < Abstract::Serializer
        attribute(:ip)
        attribute(:observable)
        attribute(:created_at) { object.created_at.iso8601(2) }
        attribute(:updated_at) { object.updated_at.iso8601(2) }

        def type
          'ip_addresses'
        end

        def self_link; end
      end
    end
  end
end
