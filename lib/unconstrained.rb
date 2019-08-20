require 'unconstrained/active_record_plugin'
require 'unconstrained/handlers'
require 'unconstrained/handlers/abstract_handler'
require 'unconstrained/handlers/postgresql'

module Unconstrained
  if defined?(Rails::Railtie)
    class Railtie < Rails::Railtie
      initializer 'unconstrained.insert_into_active_record' do
        ActiveSupport.on_load :active_record do
          ActiveRecord::Base.send(:prepend, Unconstrained::ActiveRecordPlugin)
        end
      end
    end
  elsif defined?(ActiveRecord)
    ActiveRecord::Base.send(:prepend, Unconstrained::ActiveRecordPlugin)
  end
end
