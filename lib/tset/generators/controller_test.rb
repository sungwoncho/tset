require "tset/generators/abstract"

module Tset
  module Generators
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
