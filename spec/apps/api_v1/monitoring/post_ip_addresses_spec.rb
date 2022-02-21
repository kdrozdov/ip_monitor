# frozen_string_literal: true

describe 'POST /api/v1/ip_addresses' do
  subject(:request!) { post '/api/v1/ip_addresses', request_body }

  let(:request_body) do
    {
      data: {
        type: 'ip_addresses',
        attributes: {
          ip: ip
        }
      }
    }
  end

  context 'when ip already exists' do
    let!(:ip_address) { create(:ip_address, observable: false) }
    let(:ip) { ip_address.ip }

    let(:expected_body) do
      {
        data: {
          type: 'ip_addresses',
          id: ip_address.id.to_s,
          attributes: {
            ip: ip_address.ip.to_s,
            observable: true
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

  context 'when ip does not exist' do
    let(:ip) { Faker::Internet.ip_v4_address }

    let(:expected_body) do
      {
        data: {
          type: 'ip_addresses',
          id: Common::Constants::ID_REGEX,
          attributes: {
            ip: ip,
            observable: true
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
end
