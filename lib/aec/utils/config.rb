require 'yaml'

module FAECade
  module Config

    extend self

    attr_reader :config

    def [](key)
      @config[key]
    end


    def load_config(file)
      @file = file
      @config = YAML.load_file(file)
    end

    def write_config
      File.open(@file, 'w') { |f| YAML.dump(@config, f) }
    end

  end
end
