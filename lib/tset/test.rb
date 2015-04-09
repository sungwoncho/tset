module Tset
  #
  # Contains the translated test code and the category it belongs to
  #
  # @param code [String] The actual test code translated from testable
  # @param category [String] A category used for describe block
  #
  class Test

    attr_reader :code, :category

    def initialize(code, category)
      @code = code
      @category = category
    end
  end
end
