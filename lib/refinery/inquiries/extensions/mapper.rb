require 'action_dispatch'

module ActionDispatch
  module Routing
    class Mapper
      def localizable
        if defined? localized 
          localized do
            yield
          end
        else
          yield
        end
      end
    end
  end
end
