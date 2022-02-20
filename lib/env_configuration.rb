# frozen_string_literal: true

class EnvConfiguration
  attr_reader :path, :check_required

  def initialize(path = nil, check_required: false, &block)
    @path = Array(path)
    @check_required = check_required
    instance_eval(&block)
  end

  def required(key, env_key = assume_env_key(key), &block)
    value = ENV[env_key]
    raise Required, "Config `#{env_key}` MUST be present" if check_required && (value.nil? || value.empty?)

    optional(key, env_key, &block)
  end

  def optional(key, env_key = assume_env_key(key), &block)
    value = ENV[env_key]
    raise Optional, "Config `#{env_key}` MUST be defined, but MAY be empty" if value.nil?

    value = nil if value.empty?
    field(key, value, &block)
  end

  def namespace(key, &block)
    field(key, self.class.new([*path, key], check_required: check_required, &block))
  end

  def [](key)
    fields.fetch(key.to_sym)
  end

  def to_h
    @to_h ||= fields.transform_values { |v| v.is_a?(self.class) ? v.to_h : v }
  end

  def freeze
    fields.each_value(&:freeze).freeze
    to_h.each_value(&:freeze).freeze # Hash'es nested on level 2+ will not be freezed
    super
  end

  def inspect
    "#<#{self.class} /.#{path.join('.')} > #{fields.keys.join(', ')}>"
  end

  private

  class Error < StandardError; end

  class Required < Error; end

  class Optional < Error; end

  def assume_env_key(key)
    [*path, key].map(&:upcase).join('_')
  end

  def field(key, value, &block)
    key = key.to_sym
    fields[key] = block_given? ? block.call(value) : value

    define_singleton_method(key) { fields[key] }
  end

  def fields
    @fields ||= {}
  end
end
