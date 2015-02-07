module Unconstrained
  module Handlers
    @handlers = {}
    class << self
      def register exception_name, handler
        @handlers[exception_name] = handler
      end
      def can_handle? exception
        @handlers.include? exception.try(:original_exception).try(:class).try(:name)
      end
      def handle action, exception, record
        e = exception.original_exception
        h = @handlers[e.class.name].new(e, record)
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

