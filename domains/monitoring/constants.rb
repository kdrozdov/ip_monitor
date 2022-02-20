# frozen_string_literal: true

module Monitoring
  class Constants
    IP_REGEX = Regexp.union(Resolv::IPv4::Regex, Resolv::IPv6::Regex)
  end
end
