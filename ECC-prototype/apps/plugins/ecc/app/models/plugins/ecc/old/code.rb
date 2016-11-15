class Plugins::Ecc::Code < ActiveRecord::Base
  self.table_name = 'plugins_ecc_code'
  belongs_to :site, :class_name => "CamaleonCms::Site", foreign_key :parent_id
  belongs_to :object, index: true, unique: true, foreign_key: true
  belongs_to :org, index: true, unique: true, foreign_key: true
end

