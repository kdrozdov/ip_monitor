# frozen_string_literal: true

module Notifier
  extend LunaPark::Extensions::SeverityLevels

  class << self
    attr_writer :default_severity, :notifiers

    def default_severity
      @default_severity ||= CONFIG.default_severity
    end

    def stdout
      @stdout ||= LunaPark::Notifiers::Log.new(min_lvl: default_severity)
    end

    def debug
      @debug ||= LunaPark::Notifiers::Log.new(min_lvl: :debug, format: :pretty_json)
    end

    def post(msg, lvl: :error, **tabs)
      notifiers.each { |notifier| notifier.post(msg, lvl: lvl, **tabs) }
      nil
    end

    def notifiers
      @notifiers ||= [stdout]
    end
  end
end
