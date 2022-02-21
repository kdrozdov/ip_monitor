# frozen_string_literal: true

module RepoMixins
  module Create
    def create(input, **scope_ops)
      entity = wrap(input)
      row    = to_row(entity)
      new_row = scope(dataset, **scope_ops).returning.insert(row).first
      new_attrs = from_row(new_row)
      entity.set_attributes(new_attrs)
      entity
    rescue Sequel::UniqueConstraintViolation
      raise ::Common::Errors::UniquenessError.new(model: entity.class.name)
    end
  end
end
