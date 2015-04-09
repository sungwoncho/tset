require "tset/translators/abstract"

module Tset
  module Translators
    #
    # Translates testable to an RSpec test
    #
    # @param testable [Test::Testable] An instance of testable
    #
    class Rspec < Abstract

      MODEL_TRANSLATION_RULES = [
        {
          'validations' => {
            %r(validates_presence_of (.*)) => "it { is.expected_to validate_presence_of(%s) }",
            %r(validates_uniqueness_of (.*)) => "it { is.expected_to validate_uniqueness_of(%s) }",
            %r(validates_length_of (.*), maximum: (\d*)) => "it { is.expected_to ensure_length_of(%s).is_at_most(%s) }",
            %r(validates_length_of (.*), minimum: (\d*)) => "it { is.expected_to ensure_length_of(%s).is_at_least(%s) }",
            %r(validates (\S*), presence: true) => "it { is.expected_to validate_presence_of(%s) }"
          }
        },

        {
          'associations' => {
            %r(belongs_to (.*)) => "it { is.expected_to belong_to(%s) }",
            %r(has_many (.*)) => "it { is.expected_to have_many(%s) }",
            %r(has_one (.*)) => "it { is.expected_to have_one(%s) }",
            %r(has_and_belongs_to_many (.*)) => "it { is.expected_to have_and_belong_to_many(%s) }",
            %r(has_attached_file (\S*)) => "it { is.expected_to have_attached_file(%s) }"
          }
        }
      ]

      attr_reader :testable

      def initialize(testable)
        @testable = testable
      end

      #
      # @return [Tset::Test] An object containing RSpec test corresponding to the testable and category
      #
      def start
        send("translate_#{ testable.type }")
      end

      private

      def translate_model
        MODEL_TRANSLATION_RULES.each do |rule|
          rule.values.first.each do |pattern, outcome|
            if testable.code =~ pattern
              test_code = outcome % [$1, $2]
              return Tset::Test.new(test_code, rule.keys.first)
            end
          end
        end
      end

      #
      # @param rules [Hash] a set of rules defined by key as patterns and values as matching tests
      # @param category [String] category for Tset::Test used to contain tests in appropriate describe blocks
      #
      # def evaluate_rules(rules, category)
      #   rules.each do |pattern, outcome|
      #     if testable.code =~ pattern
      #
      #     end
      #   end
      # end

    end
  end
end
