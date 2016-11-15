class CreateEccOrgs < ActiveRecord::Migration[5.0]
  def change
    create_table :plugins_ecc_orgs do |t|
      t.string :name
      t.text :desc
      t.integer :ecc_id, index:true, foreign_key: true  
    end
  end
end
