# frozen_string_literal: true

module Common
  module Errors
    class NotFound < LunaPark::Errors::System
      message { |d| "Not found #{d[:model]} by #{d[:search_by]}" }
    end

    class UniquenessError < LunaPark::Errors::Business
      message { |d| "#{d[:model]} already exists" }
    end
  end
end
