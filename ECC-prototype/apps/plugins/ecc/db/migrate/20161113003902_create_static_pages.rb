class CreateStaticPages < ActiveRecord::Migration[5.0]
  def change
    create_table :plugins_ecc_static_pages do |t|
      t.string :title, :null => false
      t.text :content, :null => false
      t.string :type, :null => false
    end
  end
end
