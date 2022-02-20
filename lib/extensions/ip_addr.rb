# frozen_string_literal: true

class IPAddr
  def self.wrap(value)
    case value
    when nil then nil
    when self then value
    when String then new(value)
    else raise ArgumentError, 'Unknown type'
    end
  end
end
