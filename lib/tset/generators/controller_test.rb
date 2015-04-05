require "tset/generators/abstract"

module Tset
  module Generator
    class ControllerTest < Abstract

      def initialize(command)
        super

        cli.class.source_root(source)
      end

      def start

      end
    end
  end
end
