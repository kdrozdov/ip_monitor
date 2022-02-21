# frozen_string_literal: true

describe 'DELETE /api/v1/ip_addresses/:ip' do
  subject(:request!) { delete "/api/v1/ip_addresses/#{ip}" }

  context 'when ip address exists' do
    let!(:ip_address) { create(:ip_address, observable: true) }
    let(:ip) { ip_address.ip }

    let(:expected_body) do
      {
        data: {
          type: 'ip_addresses',
          id: ip_address.id.to_s,
          attributes: {
            ip: ip_address.ip.to_s,
            observable: false
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

  context 'when ip address does not exist' do
    let(:ip) { Faker::Internet.ip_v4_address }

    it 'return code 404' do
      request!
      expect(last_response.status).to eq(404)
    end
  end
end
