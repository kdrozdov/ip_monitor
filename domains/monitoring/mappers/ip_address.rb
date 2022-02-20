# frozen_string_literal: true

module Monitoring
  module Mappers
    class IpAddress < LunaPark::Mappers::Simple
       class << self
        def from_row(row)
          {
            id:         row[:id],
            ip:         row[:ip],
            observable: row[:observable],
            created_at: row[:created_at],
            updated_at: row[:updated_at]
          }
        end

        def to_row(input)
          attrs = input.to_h
          row = {
            ip:         attrs[:ip],
            observable: attrs[:observable]
          }
          row[:id]         = attrs[:id]         if attrs.key?(:id)
          row[:created_at] = attrs[:created_at] if attrs.key?(:created_at)
          row[:updated_at] = attrs[:updated_at] if attrs.key?(:updated_at)
          row
        end
      end
    end
  end
end
