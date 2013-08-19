class CreateResources < ActiveRecord::Migration
  def change
    create_table :resources do |t|
      t.string :name
      t.string :subject
      t.string :format
      t.text :description
      t.integer :cost
      t.string :cost_type
      t.string :provider
      t.string :url

      t.timestamps
    end
  end
end
