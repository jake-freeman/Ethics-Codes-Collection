class Plugins::Ecc::TagTable < ActiveRecord::Base
  self.table_name = 'plugins_ecc_tagtable'
  belongs_to :site, :class_name => "CamaleonCms::Site", foreign_key :parent_id
  has_many :tags
end

