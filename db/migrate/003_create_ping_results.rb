Sequel.migration do
  up do
    run <<-SQL
      CREATE TABLE "ping_results" (
        time          TIMESTAMPTZ       NOT NULL,
        ip            INET              NOT NULL,
        rtt           DOUBLE PRECISION
      );
      SELECT create_hypertable('ping_results', 'time');
      CREATE INDEX ON ping_results (time DESC, ip);
    SQL
  end

  down do
    run <<-SQL
      DROP TABLE "ping_results";
    SQL
  end
end
