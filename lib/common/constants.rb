# frozen_string_literal: true

module Common
  module Constants
    ID_REGEX = /\A\d+\z/.freeze
    UUID_REGEX = /[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}/.freeze
    UUID_GREED_REGEX = /\A#{UUID_REGEX}\z/.freeze
  end
end
