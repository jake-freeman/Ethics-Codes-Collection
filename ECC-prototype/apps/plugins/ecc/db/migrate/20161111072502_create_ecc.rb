class CreateEcc < ActiveRecord::Migration[5.0]
  def change
    create_table :plugins_ecc do |t|
      t.integer :site_id, index: true
    end
  end
end
