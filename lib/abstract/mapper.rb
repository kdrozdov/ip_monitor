# frozen_string_literal: true

module Abstract
  class Mapper < LunaPark::Mappers::Codirectional
    def self.try_transform(hash, *keys)
      *tail_keys, head_key = keys

      if tail_keys.any?
        head_hash = hash.dig(*tail_keys)
        return unless head_hash.is_a?(Hash)
      else
        head_hash = hash
      end

      head_hash[head_key] = yield head_hash[head_key] if head_hash.key?(head_key)
    end
  end
end
