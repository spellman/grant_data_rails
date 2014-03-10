class PatientsDropDiagnosisAndRenamePatientId < ActiveRecord::Migration
  def change
    rename_column :patients, :patient_id, :study_assigned_id
    
    reversible do |dir|
      dir.up do
        remove_column :patients, :diagnosis
      end

      dir.down do
        add_column :patients, :diagnosis, :string, null: false
      end
    end
  end
end
