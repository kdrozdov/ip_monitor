# frozen_string_literal: true

module RepoMixins
  module Update
    def save(input) # rubocop:disable Metrics/AbcSize
      entity = wrap(input)
      entity.updated_at = Time.now.utc
      row = to_row(entity)
      new_row = dataset.returning.where(id: entity.id).update(row).first
      raise ::Common::Errors::NotFound.new(model: entity.class.name, search_by: entity.id) if new_row.nil?

      new_attrs = from_row(new_row)
      entity.set_attributes(new_attrs)
      entity
    end
  end
end
