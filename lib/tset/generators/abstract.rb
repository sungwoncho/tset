require "delegate"

module Tset
  module Generators
    class Abstract < SimpleDelegator
      def initialize(command)
        super(command)
      end

      def start
        raise NotImplementedError
      end
    end
  end
end
