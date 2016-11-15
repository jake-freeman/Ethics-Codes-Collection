class Plugins::Ecc::Codes < Plugins::Ecc::Ecc
  self.table_name = 'plugins_ecc_codes' 
  belongs_to :ecc, :class_name => "Plugins::Ecc::Ecc", foreign_key: :id 
  belongs_to :org, :class_name => "Plugins::Ecc::Org", foreign_key: :org_id
end

