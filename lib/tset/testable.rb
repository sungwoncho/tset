require "tset/translators/rspec"
require "tset/translators/minitest"
require "active_support/inflector"

module Tset
  #
  # Snippet of code that can be converted to a test by Writers
  #
  # @param type [String] The part of application from which the code originate (e.g. controller, model)
  # @param code [String] The testable code itself
  #
  class Testable

    TRANSLATOR_NAMESPACE = "Tset::Translators::%s"

    attr_reader :type, :code

    def initialize(type, code)
      @type = type
      @code = code
    end

    def to_test(framework = 'rspec')
      translator(framework).start
    end

    private

    def translator(framework)
      class_name = framework.classify
      Object.const_get(TRANSLATOR_NAMESPACE % class_name).new(self)
    end
  end
end
