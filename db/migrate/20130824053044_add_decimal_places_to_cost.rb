class AddDecimalPlacesToCost < ActiveRecord::Migration
  def change
    change_column :resources, :cost, :decimal, :precision => 6, :scale => 2
  end
end
