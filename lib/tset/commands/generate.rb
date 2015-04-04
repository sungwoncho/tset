require "active_support/inflector"

module Tset
  module Commands
    class Generate

      GENERATOR_NAMESPACE = "Tset::Generator::%s".freeze

      attr_reader :type, :name

      def initialize(type, name)
        @type = type
        @name = name
      end

      def start
        generator.start
      end

      private

      def generator
        require "tset/generators/#{ @type }"
        class_name = @type.classify
        Object.const_get(GENERATOR_NAMESPACE % class_name).new(self)
      end
    end
  end
end
