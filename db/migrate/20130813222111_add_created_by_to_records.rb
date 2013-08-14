class AddCreatedByToRecords < ActiveRecord::Migration

  def change
    add_column :records, :created_by, :string
  end

end
