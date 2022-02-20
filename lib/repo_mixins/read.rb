# frozen_string_literal: true

module RepoMixins
  module Read
    def find!(id, **opts)
      found! find(id, **opts), not_found_meta: id
    end

    def find(id, **opts)
      read_one scope(dataset, **opts).where(id: id)
    end

    def reload!(entity, **opts)
      new_row = scope(dataset, **opts).where(id: entity.id).first
      new_attrs = from_row(new_row)
      entity.set_attributes(new_attrs)
      entity
    end

    def count(**opts)
      scope(dataset, **opts).count
    end

    def all(**opts)
      read_all(scope(dataset, **opts).order { created_at.desc })
    end

    def last(**opts)
      to_entity from_row scope(dataset, **opts).order(:created_at).last
    end

    private

    def read_one!(dataset, not_found_meta:)
      found! read_one(dataset), not_found_meta: not_found_meta
    end

    def read_one(dataset)
      row = dataset.first
      to_entity from_row(row)
    end

    def found!(found, not_found_meta:)
      return found if found

      raise ::Common::Errors::NotFound, model: short_class_name, search_by: not_found_meta
    end

    def read_all(dataset)
      to_entities(dataset.to_a.map { |row| from_row(row) })
    end

    def short_class_name
      @short_class_name ||= self.class.name[/::(\w+)\z/, 1]
    end
  end
end
