class AddAverageScoreToResources < ActiveRecord::Migration
  def change
    add_column :resources, :average_score, :float, default: 0.0
  end
end
