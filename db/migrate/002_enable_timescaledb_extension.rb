Sequel.migration do
  up do
    run <<-SQL
      CREATE EXTENSION IF NOT EXISTS "timescaledb";
    SQL
  end

  down do
    run <<-SQL
      DROP EXTENSION IF EXISTS "timescaledb";
    SQL
  end
end
