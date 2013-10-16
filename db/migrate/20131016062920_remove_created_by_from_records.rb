class RemoveCreatedByFromRecords < ActiveRecord::Migration
  def change
    remove_column :records, :created_by, :string
  end
end
