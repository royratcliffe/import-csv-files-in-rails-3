class ImportTable < ActiveRecord::Base
  has_many :import_cells, :dependent => :destroy
end
