require "tset/generators/abstract"
require "tset/analyzers/model"
require "tset/writers/model_test"
require "active_support/inflector"

module Tset
  module Generators
    #
    # Generates blank test files in the application
    # Uses analyzers, translators, and writers to insert appropriate tests into the files.
    #
    # @param command [Tset::Commands::Generate] An instance of generate command
    #
    class ModelTest < Abstract

      attr_reader :model_name

      def initialize(command)
        super
        @model_name = name.classify

        cli.class.source_root(source)
      end

      def start
        assert_model_exists!

        opts = {
          model_name: @model_name
        }

        case framework
        when 'rspec'
          cli.template(source.join('model_spec.rspec.tt'), target.join("spec/models/#{ name }_spec.rb"), opts)
        when 'minitest'
          cli.template(source.join('model_test.minitest.tt'), target.join("test/models/#{ name }_test.rb"), opts)
        end

        testables = Tset::Analyzers::Model.new(name).start
        Tset::Writers::ModelTest.new(name, testables, framework).start!
      end

      private

      def assert_model_exists!
        unless target.join("app/models/#{ name }.rb").exist?
          raise Tset::Commands::Generate::Error.new("Unknown model: `#{ name }`")
        end
      end
    end
  end
end
