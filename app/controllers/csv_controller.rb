require 'fastercsv'

class CsvController < ApplicationController
  def import
  end

  def upload
    table = ImportTable.new :original_path => params[:upload][:csv].original_path
    row_index = 0
    FasterCSV.parse(params[:upload][:csv]) do |cells|
      column_index = 0
      cells.each do |cell|
        table.import_cells.build :column_index => column_index, :row_index => row_index, :contents => cell
        column_index += 1
      end
      row_index += 1
    end
    table.save
    redirect_to import_table_path(table)
  end
end
