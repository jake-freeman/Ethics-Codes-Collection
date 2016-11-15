class Plugins::Ecc::Orgs < Plugins::Ecc::Ecc
  self.table_name = 'plugins_ecc_orgs' 
  belongs_to :ecc, :class_name => "Plugins::Ecc::Ecc", foreign_key: :id
  has_many :codes, :class_name => "Plugins::Ecc::Codes" 
end

