# frozen_string_literal: true

module RepoMixins
  module Common
    def from_row(row)
      mapper_class ? super : row
    end

    def to_row(attrs)
      mapper_class ? super : attrs.to_h
    end

    def scope(dataset, for_update: false)
      dataset = dataset.for_update if for_update
      dataset
    end
  end
end
