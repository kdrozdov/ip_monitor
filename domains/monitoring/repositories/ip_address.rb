# frozen_string_literal: true

module Monitoring
  module Repositories
    class IpAddress < LunaPark::Repositories::Sequel
      include RepoMixins::Common
      include RepoMixins::Create
      include RepoMixins::Read
      include RepoMixins::Update

      entity Entities::IpAddress
      mapper Mappers::IpAddress

      def find_by_ip(ip, **opts)
        read_one scope(dataset, **opts).where(ip: ip)
      end

      def find_by_ip!(ip, **opts)
        read_one!(
          scope(dataset, **opts).where(ip: ip),
          not_found_meta: { ip: ip }
        )
      end

      def all_observable
        read_all scope(dataset).where(observable: true)
      end

      private

      def dataset
        DB[:ip_addresses]
      end
    end
  end
end
