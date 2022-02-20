# frozen_string_literal: true

module Monitoring
  module Scenarios
    class StopIpObserving < LunaPark::UseCases::Scenario
      include LunaPark::Extensions::Injector

      dependency(:repo) { Repositories::IpAddress.new }

      attr_accessor :ip

      def call!
        ip_address.observable = false
        repo.save(ip_address)
      end

      private

      def ip_address
        @ip_address ||= repo.find_by_ip!(ip)
      end
    end
  end
end
