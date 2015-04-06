module Tset
  module Translators
    #
    # Translates testable to an RSpec test
    #
    # @param testable [Test::Testable] An instance of testable
    #
    class Rspec < Abstract

      MODEL_TRANSLATION_RULE = {
        %r(validates_presence_of (.*)) => "it { is.expected_to validate_presence_of(%s) }",
        %r(validates (\S*), presence: true) => "it { is.expected_to validate_presence_of(%s) }",
        %r(belongs_to (.*)) => "it { is.expected_to belong_to(%s) }",
        %r(has_many (.*)) => "it { is.expected_to have_many(%s) }",
        %r(has_one (.*)) => "it { is.expected_to have_one(%s) }"
      }

      attr_reader :testable, :testable_code, :testable_type

      def initialize(testable)
        @testable = testable
        @testable_code = testable.code
        @testable_type = testable.type
      end

      #
      # @return [String] An RSpec test corresponding to the testable
      #
      def start
        send("translate_#{ testable_type }")
      end

      private

      def translate_model
        MODEL_TRANSLATION_RULE.each do |pattern, outcome|
          return outcome % $1 if testable_code =~ pattern
        end
      end
    end
  end
end
