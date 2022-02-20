# frozen_string_literal: false

require 'rack'
require 'rack/contrib'
require_relative 'config/boot'

use Rack::ApiCommonLogger
use Rack::PostBodyContentTypeParser

run UrlMap
