require "pathname"
require "active_support/inflector"

module Tset
  module Commands
    class Generate

      GENERATOR_NAMESPACE = "Tset::Generators::%sTest".freeze

      class Error < ::StandardError ; end

      attr_reader :type, :name, :framework, :cli, :source, :target

      def initialize(type, name, framework, cli)
        @type = type
        @name = name.downcase
        @framework = framework

        @cli = cli
        @source = Pathname.new(::File.dirname(__FILE__) + "/../generators/#{ @type }_test").realpath
        @target = Pathname.pwd.realpath
      end

      def start
        generator.start
      end

      private

      def generator
        require "tset/generators/#{ @type }_test"
        class_name = @type.classify
        Object.const_get(GENERATOR_NAMESPACE % class_name).new(self)
      end
    end
  end
end
