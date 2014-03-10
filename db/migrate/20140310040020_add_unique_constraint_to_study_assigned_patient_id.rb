class AddUniqueConstraintToStudyAssignedPatientId < ActiveRecord::Migration
  def change
    reversible do |dir|
      dir.up do
        execute <<-SQL
          ALTER TABLE patients
            ADD CONSTRAINT patients_study_assigned_id_unique UNIQUE (study_assigned_id);
        SQL
      end

      dir.down do
        execute <<-SQL
          ALTER TABLE patients
            DROP CONSTRAINT patients_study_assigned_id_unique;
        SQL
      end
    end
  end
end
