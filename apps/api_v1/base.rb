# frozen_string_literal: true

class ApiV1
  class Base < Sinatra::Base
    set :show_exceptions, false
    set :raise_errors, true
  end
end
