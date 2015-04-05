module Tset
  module Translators
    #
    # An abstract superclass for Translators
    #
    # @abstract
    class Abstract

      def start
        raise NotImplementedError
      end
    end
  end
end
