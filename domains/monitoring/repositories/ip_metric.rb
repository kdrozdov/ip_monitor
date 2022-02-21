# frozen_string_literal: true

module Monitoring
  module Repositories
    class IpMetric < LunaPark::Repositories::Sequel
      include RepoMixins::Common
      include RepoMixins::Create

      entity Entities::IpMetric
      mapper Mappers::IpMetric

      def for_ip_over_period(ip:, from:, to:)
        read_all dataset
          .where(ip: ip)
          .where{ time >= from }
          .where{ time <= to }
      end

      def multi_insert(input)
        entities = wrap_all(input)
        dataset.multi_insert(to_rows(entities))
        entities
      end

      private

      def dataset
        DB[:ip_metrics]
      end
    end
  end
end
