class AddStatusToResource < ActiveRecord::Migration
  def change
    add_column :resources, :status, :boolean, default: false
  end
end
