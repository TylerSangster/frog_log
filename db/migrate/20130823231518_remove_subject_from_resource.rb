class RemoveSubjectFromResource < ActiveRecord::Migration
  def change
    remove_column :resources, :subject, :string
    remove_column :resources, :format, :string
    remove_column :resources, :provider, :string
  end
end
