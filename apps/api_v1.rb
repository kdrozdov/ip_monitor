# frozen_string_literal: true

require 'uri'

class ApiV1 < Sinatra::Base
  use ApiV1::Health
  use ApiV1::Monitoring
end
