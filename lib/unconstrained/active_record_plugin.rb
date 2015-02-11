module Unconstrained
  module ActiveRecordPlugin
    extend ActiveSupport::Concern
    included do
      alias_data_modification_methods
    end

    module ClassMethods
      def alias_data_modification_methods#:nodoc:
        return if method_defined?( :save_without_constraints_handling )
        alias_method_chain :save, :constraints_handling
        alias_method_chain :destroy, :constraints_handling
      end
    end

    protected

    def save_with_constraints_handling(*args)
      with_constraints_handling :save do
        save_without_constraints_handling(*args)
      end
    end

    def destroy_with_constraints_handling
      with_constraints_handling :destroy do
        destroy_without_constraints_handling
      end
    end

    def with_constraints_handling action
      begin
        yield
      rescue ActiveRecord::InvalidForeignKey, ActiveRecord::StatementInvalid => e
        if Handlers.can_handle?( e )
          Handlers.handle( action, e, self )
        else
          raise
        end
      end
    end

  end
end
