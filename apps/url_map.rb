# frozen_string_literal: true

UrlMap = Rack::URLMap.new(
  {
    '/api/v1' => ApiV1
  }.compact
)
