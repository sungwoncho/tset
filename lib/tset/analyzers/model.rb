require "pathname"

# Reads the model file and breaks it down into an array of testables.
#
# @param name [String] the name of the model
# @return [Array] the model codes for which tests can be generated.
#
module Tset
  module Analyzers
    class Model < Abstract

      attr_reader :name, :target

      def initialize(name)
        @name = name
        @target = Pathname.pwd.join('app/models')
      end

      def start
        detect_testable_lines
      end

      private

      def detect_testable_lines
        testable_lines = []

        content = _model_file.read

        testable_patterns.each do |pattern|
          testable_lines << content.each_line.grep(pattern) do |matching_line|
            Tset::Testable.new('model', matching_line.strip)
          end
        end

        testable_lines.flatten
      end

      def _model_file
        target.join("#{ name }.rb")
      end

      def testable_patterns
        [/validates_presence_of/, /validates .*$/, /belongs_to/, /has_many/, /has_one/]
      end
    end
  end
end
