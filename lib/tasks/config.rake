# frozen_string_literal: true

namespace :config do
  task :base do
    def parse_line(line)
      match = line.match(/\A *([A-Z_]+)=(.*)\z/)
      return if match.nil?

      key   = match[1]
      value = match[2]
      [key, value]
    end
  end

  desc 'Compare ENV config files. Example: `rake config:diff[myfile1,myfile2,.env.test]`'
  task diff: :base do |_, args|
    filenames = args.to_a

    paths = {}
    filenames.each do |name|
      paths[name] = File.expand_path("../../#{name}", __dir__)
    end

    files = {}
    paths.each_pair do |name, path|
      files[name] = File.read(path)
    end

    file_vars = {}
    files.each_pair do |name, file|
      file_vars[name] = file.split("\n").map { |line| parse_line(line) }.compact.to_h
    end

    comparsion = {}
    file_vars.each_pair do |name, vars|
      vars.each do |key, value|
        comparsion[key] ||= {}
        comparsion[key][name] = value
      end
    end

    comparsion.each_key do |key|
      filenames.each do |name|
        comparsion[key][name] ||= nil
      end
    end

    differences = comparsion.reject { |_k, vars| vars.values.uniq.size <= 1 }

    pp differences
  end

  desc 'Find configs, described in default and not described in given file. Example: `rake config:missed[.env.stage]`'
  task missed: :base do |_, args|
    default_file   = File.read File.expand_path('../../.env.default', __dir__)
    default_config = default_file.split("\n").map { |line| parse_line(line) }.compact.to_h
    required_keys  = default_config.keys

    path = File.expand_path("../../#{args.to_a.first}", __dir__)
    file = File.read(path)
    vars = file.split("\n").map { |line| parse_line(line) }.compact.to_h

    missed_keys = {}
    required_keys.each do |required_key|
      next if vars.key? required_key

      missed_keys[required_key] ||= default_config[required_key]
    end

    max_key_len     = missed_keys.keys.max { |l, r| l.size <=> r.size }.size
    max_default_len = missed_keys.values.max { |l, r| l.size <=> r.size }.size
    missed_keys.each_pair do |env, default|
      puts "#{env.ljust(max_key_len)} | default: #{default.ljust(max_default_len)} |"
    end
  end
end
