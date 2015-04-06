#
# Abstract superclass for Writers
#
# @abstract
#
module Tset
  module Writers
    class Abstract

      def start!
        raise NotImplementedError
      end
    end
  end
end
