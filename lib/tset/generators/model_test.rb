require "tset/generators/abstract"

module Tset
  module Generators
    #
    # Generates blank test files in the application
    # Uses analyzers, translators, and writers to insert appropriate tests into the files.
    #
    # @param command [Tset::Commands::Generate] An instance of generate command
    #
    class ModelTest < Abstract

      def initialize(command)
        super

        @model_name = name

        cli.class.source_root(source)
      end

      def start
        assert_model_exists!

        case framework
        when 'rspec'
          cli.template(source.join('model_spec.rspec.tt'), target.join("spec/models/#{ @model_name }_spec.rb"))
        when 'minitest'
          cli.template(source.join('model_test.minitest.tt'), target.join("test/models/#{ @model_name }_test.rb"))
        end
      end

      private

      def assert_model_exists!
        unless target.join("app/models/#{ @model_name }.rb").exist?
          raise Tset::Commands::Generate::Error.new("Unknown model: `#{ @model_name }`")
        end
      end
    end
  end
end
