class Plugins::Ecc::StaticPages < Plugins::Ecc::Ecc
  self.table_name = 'plugins_ecc_static_pages' 
  include CamaleonCms::Metas

end

