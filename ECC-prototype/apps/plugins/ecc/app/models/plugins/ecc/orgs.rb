class Plugins::Ecc::Orgs < Plugins::Ecc::Ecc
  self.table_name = 'plugins_ecc_orgs' 
  has_many :codes, :class_name => "Plugins::Ecc::Codes" 
end

