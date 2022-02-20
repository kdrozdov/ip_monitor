# frozen_string_literal: true

describe 'GET /health', type: :request do
  include Rack::Test::Methods

  subject(:request!) { get '/api/v1/health' }

  context 'when there is no connection' do
    before do
      allow(DB).to receive(:test_connection).and_raise(Sequel::Error)
      allow(Notifier.notifiers.first).to receive(:post)
    end

    it 'return 500' do
      request!
      expect(last_response.status).to eq(500)
    end
  end

  context 'when connection is ok' do
    it 'return 200' do
      request!
      expect(last_response.status).to eq(200)
    end
  end

  context 'when exception raised' do
    before do
      allow(DB).to receive(:test_connection).and_raise(Exception)
    end

    it 'return 500' do
      request!
      expect(last_response.status).to eq(500)
    end
  end
end
