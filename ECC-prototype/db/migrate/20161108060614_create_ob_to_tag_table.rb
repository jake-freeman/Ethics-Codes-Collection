class CreateObToTagTable < ActiveRecord::Migration[5.0]
  def change
    create_table :ob_to_tag_tables do |t|
      t.integer :object_id, :tag_id
    end
  end
end
