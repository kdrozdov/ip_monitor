# frozen_string_literal: true

module Monitoring
  module Entities
    class PingResult < LunaPark::Entities::Attributable
      attr :ip, IPAddr, :wrap
      attr :time
      attr :rtt
    end
  end
end
