class AddResourceToReviews < ActiveRecord::Migration
  def change
    add_column :reviews, :resource_id, :integer
  end
end
