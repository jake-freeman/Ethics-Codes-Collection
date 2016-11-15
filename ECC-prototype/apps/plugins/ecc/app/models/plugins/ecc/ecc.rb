class Plugins::Ecc::Ecc < ApplicationRecord
  self.table_name = 'plugins_ecc' 
  include CamaleonCms::Metas
  belongs_to :site, :class_name => "CamaleonCms::Site", foreign_key: :site_id
  has_many :ecc_orgs, :class_name => "Plugins::Ecc::Orgs"
end

