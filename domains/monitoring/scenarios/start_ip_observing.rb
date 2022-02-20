# frozen_string_literal: true

module Monitoring
  module Scenarios
    class StartIpObserving < LunaPark::UseCases::Scenario
      include LunaPark::Extensions::Injector

      dependency(:repo) { Repositories::IpAddress.new }

      attr_accessor :ip

      def call!
        ip_address.observable = true

        new_ip_address? ? repo.create(ip_address) : repo.save(ip_address)
      end

      private

      def ip_address
        @ip_address ||=
          repo.find_by_ip(ip) || Entities::IpAddress.new(ip: ip)
      end

      def new_ip_address?
        ip_address.id.nil?
      end
    end
  end
end
