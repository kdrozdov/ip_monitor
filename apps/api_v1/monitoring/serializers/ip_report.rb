# frozen_string_literal: true

class ApiV1
  class Monitoring
    module Serializers
      class IpReport < Abstract::Serializer
        attribute(:ip)
        attribute(:avg_rtt)
        attribute(:min_rtt)
        attribute(:max_rtt)
        attribute(:median_rtt)
        attribute(:stddev_rtt)
        attribute(:losses)

        def type
          'ip_reports'
        end

        def id
          object.ip
        end

        def self_link
          "/api/v1/#{type}/#{object.ip}"
        end
      end
    end
  end
end
