# frozen_string_literal: true

module Monitoring
  module Entities
    class IpAddress < LunaPark::Entities::Attributable
      attr :id
      attr :ip, IPAddr, :wrap
      attr :observable
      attr :created_at
      attr :updated_at
    end
  end
end
