module Tset
  module Analyzers
    #
    # Abstract superclass for analyzers
    #
    # @abstract
    #
    class Abstract

      def start
        raise NotImplementedError
      end
    end
  end
end
