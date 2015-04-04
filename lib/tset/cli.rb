require "thor"

module Tset
  class Cli < Thor
    include Thor::Actions

    desc 'version', 'prints Tset version'
    def version
      puts "v#{ Tset::VERSION }"
    end

    desc 'generate', 'generates tests'
    def generate(type = nil, name = nil)
      if options[:help] || (type.nil? && name.nil?)
        invoke :help, ['generate']
      else
        require "tset/commands/generate"
        Tset::Commands::Generate.new(type, name).start
      end
    end
  end
end
