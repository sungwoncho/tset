module Tset
  module Translators
    #
    # Translates testable to a minitest test
    #
    # @param testable [Test::Testable] An instance of testable
    #
    class MiniTest < Abstract

      def initialize(testable)
        @testable = testable
      end

      def start

      end
    end
  end
end
