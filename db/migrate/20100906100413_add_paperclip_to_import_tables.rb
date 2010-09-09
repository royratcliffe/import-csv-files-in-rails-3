class AddPaperclipToImportTables < ActiveRecord::Migration
  def self.up
    add_column :import_tables, :csv_file_name, :string
    add_column :import_tables, :csv_content_type, :string
    add_column :import_tables, :csv_file_size, :integer
    add_column :import_tables, :csv_updated_at, :datetime
  end

  def self.down
    remove_column :import_tables, :csv_updated_at
    remove_column :import_tables, :csv_file_size
    remove_column :import_tables, :csv_content_type
    remove_column :import_tables, :csv_file_name
  end
end
