class CreateInterests < ActiveRecord::Migration
  def change
    create_table :interests do |t|
      t.integer :user_id
      t.integer :resource_id

      t.timestamps
    end
    add_index :interests, :user_id
    add_index :interests, :resource_id
    add_index :interests, [:user_id, :resource_id], unique: true
  end
end
