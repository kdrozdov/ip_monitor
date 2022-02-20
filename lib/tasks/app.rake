# frozen_string_literal: true

namespace :app do
  desc 'Open an racksh session'
  task :console do
    system 'bundle exec racksh'
  end

  desc 'Start server in development mode'
  task :server do
    require_relative '../../config/root'

    FileUtils.mkpath(File.expand_path('tmp/pids', APP_ROOT))

    exec "rerun 'puma -C config/puma.rb' --background"
  end
end
