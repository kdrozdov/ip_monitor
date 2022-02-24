# frozen_string_literal: true

module Monitoring
  module Mappers
    class PingResult < LunaPark::Mappers::Simple
      class << self
        def from_row(row)
          {
            time: row[:time],
            ip:   row[:ip],
            rtt:  row[:rtt]
          }
        end

        def to_row(input)
          attrs = input.to_h
          {}.tap do |row|
            row[:time] = attrs[:time]
            row[:ip]   = attrs[:ip]
            row[:rtt]  = attrs[:rtt]
          end
        end
     end
    end
  end
end
