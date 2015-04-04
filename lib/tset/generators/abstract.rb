require "delegate"

module Tset
  module Generator
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
