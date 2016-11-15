class CreateObjectTable < ActiveRecord::Migration[5.0]
  def change
    create_table :object_tables do |t|
      t.integer :object_id
    end
  end
end
