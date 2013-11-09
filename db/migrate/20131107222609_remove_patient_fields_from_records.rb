class RemovePatientFieldsFromRecords < ActiveRecord::Migration
  def change
    reversible do |dir|
      dir.up do
        change_table :records do |t|
          t.remove :name, :diagnosis
        end
      end
      dir.down do
        change_table :records do |t|
          t.string :name
          t.string :diagnosis
        end
      end
    end
  end
end
