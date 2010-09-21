module ActiveRecord
  class Base
    class << self
      # Turns a +table_name+ into a class name. Singularise the table name, if
      # table names are pluralised; then camelise. This follows the basic
      # technique used by the +initialize+ method at
      # activerecord-3.0.0.rc/lib/active_record/fixtures.rb:543.
      def class_name(table_name = self.table_name)
        (ActiveRecord::Base.pluralize_table_names ? table_name.singularize : table_name).camelize
      end
    end
  end
end
