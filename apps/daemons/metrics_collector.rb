# frozen_string_literal: true
require_relative '../../config/boot'

CYCLE_PERIOD = 5

thread_pool       = Concurrent::FixedThreadPool.new(10)
ip_addresses_repo = Monitoring::Repositories::IpAddress.new
ip_metrics_repo   = Monitoring::Repositories::IpMetric.new

loop do
  addresses = ip_addresses_repo.all_observable
  executors = addresses.map do |address|
    Concurrent::Future.execute({ executor: thread_pool }) do
      time = Time.now
      ping = Net::Ping::External.new(address.ip.to_s).tap { |p| p.ping }
      { ip: address.ip, rtt: ping.duration, time: time }
    end
  end
  ping_results = executors.map(&:value!).compact
  ip_metrics_repo.multi_insert(ping_results)

  puts "Iteration succees; Next in #{CYCLE_PERIOD}"
  sleep(CYCLE_PERIOD)
end
