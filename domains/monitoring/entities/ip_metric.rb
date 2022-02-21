# frozen_string_literal: true

module Monitoring
  module Entities
    class IpMetric < LunaPark::Entities::Attributable
      attr :time
      attr :ip, IPAddr, :wrap
      attr :rtt
    end
  end
end
