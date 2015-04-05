#
# Representation of action and its content in a controller
#
# @param name [String] a name of an action
# @param body [String] a content of an action
#
module Tset
  module Analyzers
    class Action

      def initialize(name, body)
        @name = name
        @body = body
      end
    end
  end
end
