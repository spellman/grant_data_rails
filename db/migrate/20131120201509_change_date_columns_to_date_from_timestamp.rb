class ChangeDateColumnsToDateFromTimestamp < ActiveRecord::Migration
  def change
    reversible do |dir|
      dir.up do
        change_column :a1cs,         :date, :date, null: false
        change_column :acrs,         :date, :date, null: false
        change_column :bmis,         :date, :date, null: false
        change_column :cholesterols, :date, :date, null: false
        change_column :ckd_stages,   :date, :date, null: false
        change_column :eye_exams,    :date, :date, null: false
        change_column :flus,         :date, :date, null: false
        change_column :foot_exams,   :date, :date, null: false
        change_column :livers,       :date, :date, null: false
        change_column :pneumonias,   :date, :date, null: false
        change_column :renals,       :date, :date, null: false
      end
      dir.down do
        change_column :a1cs,         :date, :datetime, null: false
        change_column :acrs,         :date, :datetime, null: false
        change_column :bmis,         :date, :datetime, null: false
        change_column :cholesterols, :date, :datetime, null: false
        change_column :ckd_stages,   :date, :datetime, null: false
        change_column :eye_exams,    :date, :datetime, null: false
        change_column :flus,         :date, :datetime, null: false
        change_column :foot_exams,   :date, :datetime, null: false
        change_column :livers,       :date, :datetime, null: false
        change_column :pneumonias,   :date, :datetime, null: false
        change_column :renals,       :date, :datetime, null: false
      end
    end
  end
end
