class CreatePagetype < ActiveRecord::Migration[5.0]
  def change
    create_table :plugins_ecc_pagetypes do |t|
      t.text :description
    end
  end
end
