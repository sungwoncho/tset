require "delegate"

module Tset
  module Generators
    #
    # An abstract superclass of Generators
    #
    # @param command [Tset::Commands::Generate] An instance of generate command
    # @abstract
    #
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
