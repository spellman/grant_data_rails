class RequirePatientIdForeignKeyInPatientDataModels < ActiveRecord::Migration
  def change
    reversible do |dir|
      dir.up do
        change_column :a1cs,         :patient_id, :integer, null: false
        change_column :acrs,         :patient_id, :integer, null: false
        change_column :bmis,         :patient_id, :integer, null: false
        change_column :cholesterols, :patient_id, :integer, null: false
        change_column :ckd_stages,   :patient_id, :integer, null: false
        change_column :eye_exams,    :patient_id, :integer, null: false
        change_column :flus,         :patient_id, :integer, null: false
        change_column :foot_exams,   :patient_id, :integer, null: false
        change_column :livers,       :patient_id, :integer, null: false
        change_column :pneumonias,   :patient_id, :integer, null: false
        change_column :renals,       :patient_id, :integer, null: false
      end
      dir.down do
        change_column :a1cs,         :patient_id, :integer
        change_column :acrs,         :patient_id, :integer
        change_column :bmis,         :patient_id, :integer
        change_column :cholesterols, :patient_id, :integer
        change_column :ckd_stages,   :patient_id, :integer
        change_column :eye_exams,    :patient_id, :integer
        change_column :flus,         :patient_id, :integer
        change_column :foot_exams,   :patient_id, :integer
        change_column :livers,       :patient_id, :integer
        change_column :pneumonias,   :patient_id, :integer
        change_column :renals,       :patient_id, :integer
      end
    end
  end
end
