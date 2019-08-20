module Unconstrained
  module Handlers
    @handlers = {}
    class << self
      def register(exception_name, handler)
        @handlers[exception_name] = handler
      end

      def handler(exception)
        @handlers.detect { |k, _| exception.message.start_with?(k) }&.last
      end

      def handle(action, exception, record)
        h = handler(exception).new(exception.message, record)
        case action
        when :destroy
          h.handle_destroy
        when :save
          h.handle_save
        end
      end
    end
  end
end
