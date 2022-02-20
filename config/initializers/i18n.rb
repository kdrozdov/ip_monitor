# frozen_string_literal: true

require 'i18n/backend/fallbacks'

I18n::Backend::Simple.include I18n::Backend::Fallbacks

I18n.load_path << Dir["#{File.expand_path('config/i18n')}/*.yml"]
I18n.config.enforce_available_locales = false
I18n.config.default_locale = :en
I18n.config.available_locales = %i[en]
# @return
# I18n.fallbacks[:en] => [:en, :en]
# I18n.fallbacks[:ru] => [:ru, :en]
# I18n.fallbacks[:unknown] => [:unknown, :en]
I18n.fallbacks = Hash.new { |_, locale| [locale, I18n.default_locale] }
