# frozen_string_literal: true

require "test_prof/any_fixture/dump/base_adapter"

module TestProf
  module AnyFixture
    class Dump
      class Mysql < BaseAdapter

        def reset_sequence!(table_name, start)
          execute <<~SQL
            ALTER TABLE #{table_name} AUTO_INCREMENT = 1; -- any_fixture:dump
          SQL
        end

        def compile_sql(sql, binds)
          sql.gsub(/\$\d+/) { binds.shift.gsub("\n", "' || chr(10) || '") }
        end

        def execute(query)
          super&.values
        end

      end
    end
  end
end
