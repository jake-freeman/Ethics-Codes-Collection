class Plugins::Ecc::Object < ActiveRecord::Base
  self.table_name = 'plugins_ecc_object'
  belongs_to :site, :class_name => "CamaleonCms::Site", foreign_key :parent_id
  has_one :tagtable
end

