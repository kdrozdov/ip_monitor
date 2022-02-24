# frozen_string_literal: true

require 'rubygems' unless defined?(Gem)
require 'bundler/setup'
require_relative 'root'
require_relative 'config'
Bundler.require(:default, CONFIG.app_env)

loader = Zeitwerk::Loader.new # root: APP_ROOT
loader.preload 'lib/notifier.rb'
loader.preload 'lib/extensions/ip_addr.rb'
loader.preload 'config/initializers'
loader.preload 'lib/abstract'
loader.preload 'lib/common'
loader.preload 'lib/repo_mixins'
loader.preload 'lib/http/helpers'
loader.preload 'lib/http'
loader.preload 'lib/rack'
loader.push_dir 'domains'
loader.push_dir 'apps'
loader.setup
