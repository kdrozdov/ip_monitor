# frozen_string_literal: true

module Monitoring
  module Scenarios
    class BuildPingReport < LunaPark::UseCases::Scenario
      include LunaPark::Extensions::Injector

      error :no_metrics_found, 'No metrics found for the given interval'

      dependency(:ping_report_query) { Queries::PingReport }

      attr_accessor :ip, :from, :to

      def call!
        error :no_metrics_found unless report_data[:total_count].positive?
        Dto::PingReport.new(
          ip: ip,
          avg_rtt: report_data[:avg_rtt],
          min_rtt: report_data[:min_rtt],
          max_rtt: report_data[:max_rtt],
          stddev_rtt: report_data[:stddev_rtt],
          median_rtt: report_data[:median_rtt],
          losses: losses
        )
      end

      private

      def losses
        @losses ||= begin
          total_count = report_data[:total_count]
          lost_count = total_count - report_data[:count_with_rtt]
          lost_count.to_f / total_count * 100.0
        end
      end

      def report_data
        @report_data ||= ping_report_query.call(ip: ip, from: from, to: to)
      end
    end
  end
end
