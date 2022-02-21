Sequel.migration do
  up do
    run <<-SQL
      CREATE TABLE "ip_metrics" (
        time          TIMESTAMPTZ       NOT NULL,
        ip            INET              NOT NULL,
        rtt           DOUBLE PRECISION
      );
      SELECT create_hypertable('ip_metrics', 'time');
      CREATE INDEX ON ip_metrics (time DESC, ip);
    SQL
  end

  down do
    run <<-SQL
      DROP TABLE "ip_metrics";
    SQL
  end
end
