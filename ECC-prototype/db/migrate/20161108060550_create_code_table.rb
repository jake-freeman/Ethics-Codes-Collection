class CreateCodeTable < ActiveRecord::Migration[5.0]
  def change
    create_table :code_tables do |t|
      t.string :title
      t.text :code_body, :description
      t.date :year_pub
      t.integer :code_id, :tag_id, :org_id
    end
  end
end
