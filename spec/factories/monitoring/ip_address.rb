# frozen_string_literal: true

FactoryBot.define do
  factory :ip_address, class: 'Monitoring::Entities::IpAddress' do
    ip                        { Faker::Internet.ip_v4_address }

    trait :stub do
      sequence(:id)
      created_at              { Time.now }
      updated_at              { Time.now }
    end

    initialize_with { new(attributes) }

    to_create do |instance|
      Monitoring::Repositories::IpAddress.new.create(instance)
    end
  end
end
