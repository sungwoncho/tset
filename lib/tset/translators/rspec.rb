module Tset
  module Translators
    #
    # Translates testable to an RSpec test
    #
    # @param testable [Test::Testable] An instance of testable
    #
    class Rspec < Abstract

      attr_reader :testable

      def initialize(testable)
        @testable = testable
      end

      def testable_code
        @testable_code ||= @testable.code
      end

      def testable_type
        @testable_type ||= @testable.type
      end

      #
      # @return [String] An RSpec test corresponding to the testable
      #
      def start
        send("translate_#{ testable_type }")
      end

      private

      def translate_model
        case testable_code
        when /validates_presence_of (.*)/
          "it { is.expected_to validate_presence_of(#{$1}) }"
        when /validates (\S*), presence: true/
          "it { is.expected_to validate_presence_of(#{$1}) }"
        when /belongs_to (.*)/
          "it { is.expected_to belong_to(#{$1}) }"
        when /has_many (.*)/
          "it { is.expected_to have_many(#{$1}) }"
        when /has_one (.*)/
          "it { is.expected_to have_one(#{$1}) }"
        end
      end
    end
  end
end
