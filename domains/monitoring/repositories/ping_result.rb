# frozen_string_literal: true

module Monitoring
  module Repositories
    class PingResult < LunaPark::Repositories::Sequel
      include RepoMixins::Common
      include RepoMixins::Create

      entity Entities::PingResult
      mapper Mappers::PingResult

      def for_ip_over_period(ip:, from:, to:)
        read_all dataset
          .where(ip: ip)
          .where{ |r| r.time >= from }
          .where{ |r| r.time <= to }
      end

      def multi_insert(input)
        entities = wrap_all(input)
        dataset.multi_insert(to_rows(entities))
        entities
      end

      private

      def dataset
        DB[:ping_results]
      end
    end
  end
end
