class AddPhotoToResources < ActiveRecord::Migration
  def change
    add_column :resources, :resource_photo, :string
  end
end
