module Unconstrained
  module Handlers
    class PostgreSQLFKHandler < AbstractHandler
      def constraint_error_column
        @message =~ /DETAIL:  Key \((\w+)\)/ && $1
      end

      def constraint_error_table
        @message =~ /referenced from table "(\w+)"/ && $1
      end
    end

    Handlers.register 'PG::ForeignKeyViolation', PostgreSQLFKHandler
  end
end
