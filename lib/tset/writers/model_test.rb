require "tset/writers/abstract"

module Tset
  module Writers
    #
    # Writes the test for a model for each testable codes given
    #
    # @param model_name [String] a name of the model
    # @param testables [Array] an array of lines of code returned by Tset::Analyzers::Model
    # @param framework [String] a test framework. Default to 'rspec'.
    #
    class ModelTest < Abstract

      attr_reader :name, :testables, :framework, :target

      def initialize(model_name, testables, framework = 'rspec')
        @model_name = model_name
        @testables = testables
        @framework = framework

        @target = Pathname.pwd.realpath
      end

      def start!
        case framework
        when 'rspec'
          testables.each { |testable| write_rspec(testable) }
        when 'minitest'
        end
      end

      private

      def write_rspec(testable)
        test = testable.to_test('rspec')
        File.open(_rspec_file, 'w') { |file| file.write(test) }
      end

      def _rspec_file
        target.join("spec/models/#{ @model_name }_spec.rb")
      end
    end
  end
end
