class EditStaticPagesTable < ActiveRecord::Migration[5.0]
  def up
    remove_column :plugins_ecc_static_pages, :pagetype
  end
  def down
    add_column :plugins_ecc_static_pages, :pagetype, :integer
  end
end
