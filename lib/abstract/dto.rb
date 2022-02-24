# frozen_string_literal: true

module Abstract
  class Dto
    include LunaPark::Extensions::Attributable
    extend LunaPark::Extensions::Dsl::Attributes

    def initialize(attrs = {})
      set_attributes attrs
    end
  end
end
