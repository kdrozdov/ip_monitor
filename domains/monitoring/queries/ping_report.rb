# frozen_string_literal: true

module Monitoring
  module Queries
    class PingReport
      extend LunaPark::Extensions::Callable

      attr_reader :ip, :from, :to

      def initialize(ip:, from:, to:)
        @ip = ip
        @from = from
        @to = to
      end

      def call
        ds = dataset.select(
          Sequel.function(:count, '*').as(:count_with_rtt),
          Sequel.function(:min, :rtt).as(:min_rtt),
          Sequel.function(:max, :rtt).as(:max_rtt),
          Sequel.function(:avg, :rtt).as(:avg_rtt),
          Sequel.function(:stddev_samp, :rtt).as(:stddev_rtt),
          Sequel.lit('percentile_cont(0.5) WITHIN GROUP (ORDER BY rtt) as median_rtt')
        )

        ds = for_ip_over_period(ds)
        ds = with_rtt(ds)

        ds.first.merge(total_count: total_count)
      end

      private

      def with_rtt(scope)
        scope.where(Sequel.~(rtt: nil))
      end

      def for_ip_over_period(scope)
        scope
          .where(ip: ip)
          .where{ |r| r.time >= from }
          .where{ |r| r.time <= to }
      end

      def total_count
        for_ip_over_period(dataset).count
      end

      def dataset
        DB[:ping_results]
      end
    end
  end
end
