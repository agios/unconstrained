module Unconstrained
  module ActiveRecordPlugin
    def save(*args)
      with_constraints_handling :save do
        super(*args)
      end
    end

    def destroy
      with_constraints_handling :destroy do
        super
      end
    end

    def with_constraints_handling(action)
      yield
    rescue ActiveRecord::InvalidForeignKey, ActiveRecord::StatementInvalid => e
      raise unless Handlers.handler(e)

      Handlers.handle(action, e, self)
    end
  end
end
