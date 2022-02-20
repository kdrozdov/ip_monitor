# frozen_string_literal: true

module Abstract
  class Serializer
    include JSONAPI::Serializer

    def self_link
      "/api/v1/#{type}/#{object.id}"
    end

    def format_name(attribute_name)
      attribute_name.to_s
    end
  end
end
