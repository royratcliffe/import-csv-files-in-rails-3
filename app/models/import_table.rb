class ImportTable < ActiveRecord::Base
  has_attached_file :csv, :storage => :s3, :s3_credentials => Rails.root.join('config/s3.yml'), :path => ':attachment/:id.:extension'
end
