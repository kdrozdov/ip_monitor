# frozen_string_literal: true

require 'sequel'

Sequel.extension :pg_json_ops

DB = Sequel.connect(CONFIG.db.to_h)
DB.extension :pg_inet
