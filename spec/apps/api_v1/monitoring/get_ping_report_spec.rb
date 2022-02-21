# frozen_string_literal: true

describe 'GET /api/v1/ping_reports/:ip' do
  subject(:request!) { get "/api/v1/ping_reports/#{ip}?from=#{from}&to=#{to}" }

  let(:ip)   { Faker::Internet.ip_v4_address }
  let(:from) { Time.now - 3600 }
  let(:to)   { Time.now + 3600 }

  let!(:ping_results) do
    create(:ping_result, ip: ip, rtt: 0.2)
    create(:ping_result, ip: ip, rtt: 0.4)
    create(:ping_result, ip: ip, rtt: 0.6)
    create(:ping_result, ip: ip, rtt: nil)
  end

  let(:eps) { 1e-5 }

  let(:expected_body) do
    {
      data: {
        type: 'ping_reports',
        attributes: {
          ip: ip,
          avg_rtt: be_within(eps).of(0.4),
          min_rtt: be_within(eps).of(0.2),
          max_rtt: be_within(eps).of(0.6),
          median_rtt: be_within(eps).of(0.4),
          losses: 25
        }
      }
    }
  end

  it 'return code 200' do
    request!
    expect(last_response.status).to eq(200)
  end

  it 'return expected data' do
    request!
    expect(last_response.body).to include_json(expected_body)
  end
end
