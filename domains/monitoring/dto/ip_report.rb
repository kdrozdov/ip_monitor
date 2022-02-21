# frozen_string_literal: true

module Monitoring
  module Dto
    class IpReport < Abstract::Dto
      attr :ip
      attr :avg_rtt
      attr :min_rtt
      attr :max_rtt
      attr :median_rtt
      attr :stddev_rtt
      attr :losses
    end
  end
end
