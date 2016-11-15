 class Plugins::Ecc::Ecc < ActiveRecord::Base
  include CamaleonCms::Metas
  self.table_name = 'plugins_ecc' 
  default_scope { where(kind: 'ecc')}
  belongs_to :site, :class_name => "CamleonCms::Site", foreign_key: site_id

 end
