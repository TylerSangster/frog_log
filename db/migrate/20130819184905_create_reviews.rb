class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.integer :user_id
      t.integer :score
      t.string :title
      t.text :content
      t.timestamps
    end
  end
end
