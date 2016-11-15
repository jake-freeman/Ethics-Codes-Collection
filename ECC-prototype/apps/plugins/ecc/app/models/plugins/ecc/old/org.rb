class Plugins::Ecc::Org < ActiveRecord::Base
  self.table_name = 'plugins_ecc_org'
  belongs_to :site, :class_name => "CamaleonCms::Site", foreign_key :parent_id
  belongs_to :object, index: true, unique: true, foreign_key: true
  has_many :codes
end

