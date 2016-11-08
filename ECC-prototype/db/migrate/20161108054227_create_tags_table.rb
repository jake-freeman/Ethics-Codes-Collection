class CreateTagsTable < ActiveRecord::Migration[5.0]
  def change
    create_table :tags_tables do |t|
      t.string :name
      t.integer :tag_id
    end
  end
end
