class RemoveImportCells < ActiveRecord::Migration
  def self.up
    remove_index :import_cells, :column => [:import_table_id]
    drop_table :import_cells
  end

  def self.down
    create_table :import_tables do |t|
      t.string :original_path

      t.timestamps
    end
    add_index :import_cells, [:import_table_id]
  end
end
