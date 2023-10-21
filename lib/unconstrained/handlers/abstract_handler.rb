module Unconstrained
  module Handlers
    class AbstractHandler
      def initialize(message, record)
        @message = message
        @record = record
      end

      def handle_save
        column_name = constraint_error_column
        if column_name == @record.class.primary_key
          @record.errors.add(:base, save_error_key, **save_error_options)
        else
          @record.errors.add(column_name.to_sym, save_error_key, **save_error_options)
        end
      end

      def handle_destroy
        @record.errors.add(:base, destroy_error_key, **destroy_error_options)
      end

      def save_error_key
        :invalid
      end

      def save_error_options
        {}
      end

      def destroy_error_key
        :"restrict_dependent_destroy.has_many"
      end

      def destroy_error_options
        { record: constraint_error_table.humanize.downcase }
      end

      def constraint_error_column; end

      def constraint_error_table; end
    end
  end
end
