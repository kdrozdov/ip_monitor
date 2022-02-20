# frozen_string_literal: true

class ApiV1
  class Health < Base
    get '/health' do
      DB.test_connection
    rescue Sequel::Error => e
      Notifier.error(e)
      halt 500
    end
  end
end
