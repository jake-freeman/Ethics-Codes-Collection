class CreateDbStructure < ActiveRecod::Migration
  def change
    unless table_exists? 'plugins_codes'
      create_table :plugins_code do |t|
        t.integer :code_id, :org_id, :tag_id
        t.string :name, :slug
        t.text :code_chunk
        t.date :year
      end
  end 
    CamaleonCMS::Site.all.each do |s|
      s.plugins.where(slug: 'code').update_all(slug:'code')
    end
  end
end


