class CreateOrganizationsTable < ActiveRecord::Migration[5.0]
  def change
    create_table :organizations_tables do |t|
      t.string :name
      t.text :bio
      t.integer :org_id
    end
  end
end
