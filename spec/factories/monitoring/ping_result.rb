# frozen_string_literal: true

FactoryBot.define do
  factory :ping_result, class: 'Monitoring::Entities::PingResult' do
    time { Time.now }
    ip   { Faker::Internet.ip_v4_address }
    rtt  { 0.1 }

    initialize_with { new(attributes) }

    to_create do |instance|
      Monitoring::Repositories::PingResult.new.create(instance)
    end
  end
end
