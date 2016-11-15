class Plugins::Ecc::Tag < ActiveRecord::Base
  self.table_name = 'plugins_ecc_tag'
  belongs_to :site, :class_name => "CamaleonCms::Site", foreign_key :parent_id
end

