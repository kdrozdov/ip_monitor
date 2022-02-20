# frozen_string_literal: true

namespace :db do
  desc 'Create database'
  task create: :config do
    cmd = "PGPASSWORD=#{CONFIG.db.password} createdb" \
          " --username=#{CONFIG.db.username}" \
          " --host=#{CONFIG.db.host}" \
          " #{CONFIG.db.database}"
    puts "Database `#{CONFIG.db.database}` successfully created" if system(cmd)
  end

  desc 'Drop database'
  task drop: :config do
    cmd = "PGPASSWORD=#{CONFIG.db.password} dropdb" \
          " --username=#{CONFIG.db.username}" \
          " --host=#{CONFIG.db.host}" \
          " #{CONFIG.db.database}"
    puts "Database `#{CONFIG.db.database}` successfully dropped" if system(cmd)
  end

  desc 'Apply migrations'
  task :migrate, [:version] => :config do |_, args|
    require 'logger'
    require 'sequel/core'

    Sequel.extension :migration
    version = args[:version] ? args[:version].to_i : nil
    migrations_path = File.join(APP_ROOT, 'db', 'migrate')

    Sequel.connect(CONFIG.db.to_h, logger: Logger.new($stdout)) do |db|
      db.extension :pg_json
      Sequel::Migrator.run(db, migrations_path, target: version)
    end
  end

  desc 'Database console'
  task console: :config do
    cmd = "PGPASSWORD=#{CONFIG.db.password} psql" \
          " --username=#{CONFIG.db.username}" \
          " --host=#{CONFIG.db.host}" \
          " --port=#{CONFIG.db.port}" \
          " #{CONFIG.db.database}"
    puts "Database `#{CONFIG.db.database}` says 'bye-bye'" if system(cmd)
  end

  desc 'Reset database - drop, create, & migrate'
  task :reset do
    Rake::Task['db:drop'].invoke
    Rake::Task['db:create'].invoke
    Rake::Task['db:migrate'].invoke
  end
end
