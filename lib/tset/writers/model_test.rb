require "tset/writers/abstract"
require "active_support/inflector"

module Tset
  module Writers
    #
    # Writes the test for a model for each testable codes given
    #
    # @param model_name [String] a name of the model (e.g. post)
    # @param testables [Array] an array of lines of code returned by Tset::Analyzers::Model
    # @param framework [String] a test framework. Default to 'rspec'.
    #
    class ModelTest < Abstract

      attr_reader :model_name, :testables, :framework, :target

      def initialize(model_name, testables, framework = 'rspec')
        @model_name = model_name
        @testables = testables
        @framework = framework

        @target = Pathname.pwd.realpath
      end

      #
      # @return [String] A classified version of the name (e.g. Post)
      #
      def class_name
        @class_name ||= model_name.classify
      end

      def start!
        case framework
        when 'rspec'
          testables.each { |testable| write_rspec(testable) }
        when 'minitest'
        end
      end

      private

      #
      # Translates the testable into rspec and writes to rspec file
      #
      # @param testable [Tset::Testable]
      #
      def write_rspec(testable)
        test = testable.to_test('rspec')

        file_contents = File.read(_rspec_file)

        describe(test.category) unless file_contents =~ /describe "#{test.category}" do/
        expectation(test)
      end

      #
      # Writes a describe block
      #
      # @param category [String] notion that is being described
      #
      def describe(category)
        file_contents = File.read(_rspec_file)
        replacement = %Q(describe #{class_name} do

  describe "#{category}" do
  end)
        file_contents.gsub!(/describe #{class_name} do/, replacement)
        File.write(_rspec_file, file_contents)
      end

      #
      # Writes an expectation
      #
      # @param test [Tset::Tset]
      #
      def expectation(test)
        file_contents = File.read(_rspec_file)
        replacement = %Q(  describe "#{test.category}" do
    #{test.code})
        file_contents.gsub!(/\s\sdescribe "#{test.category}" do/, replacement)
        File.write(_rspec_file, file_contents)
      end

      def _rspec_file
        target.join("spec/models/#{ @model_name }_spec.rb")
      end
    end
  end
end
