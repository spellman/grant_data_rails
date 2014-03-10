class AddUniquePtAndDateConstraints < ActiveRecord::Migration
  def change
    reversible do |dir|
      dir.up do
        execute <<-SQL
          ALTER TABLE a1cs
            ADD CONSTRAINT a1cs_unique_patient_id_date UNIQUE (patient_id, date);
          ALTER TABLE acrs
            ADD CONSTRAINT acrs_unique_patient_id_date UNIQUE (patient_id, date);
          ALTER TABLE bmis
            ADD CONSTRAINT bmis_unique_patient_id_date UNIQUE (patient_id, date);
          ALTER TABLE cholesterols
            ADD CONSTRAINT cholesterols_unique_patient_id_date UNIQUE (patient_id, date);
          ALTER TABLE ckd_stages
            ADD CONSTRAINT ckd_stages_unique_patient_id_date UNIQUE (patient_id, date);
          ALTER TABLE eye_exams
            ADD CONSTRAINT eye_exams_unique_patient_id_date UNIQUE (patient_id, date);
          ALTER TABLE flus
            ADD CONSTRAINT flus_unique_patient_id_date UNIQUE (patient_id, date);
          ALTER TABLE foot_exams
            ADD CONSTRAINT foot_exams_unique_patient_id_date UNIQUE (patient_id, date);
          ALTER TABLE livers
            ADD CONSTRAINT livers_unique_patient_id_date UNIQUE (patient_id, date);
          ALTER TABLE pneumonias
            ADD CONSTRAINT pneumonias_unique_patient_id_date UNIQUE (patient_id, date);
          ALTER TABLE renals
            ADD CONSTRAINT renals_unique_patient_id_date UNIQUE (patient_id, date);
        SQL
      end

      dir.down do
        execute <<-SQL
          ALTER TABLE a1cs
            DROP CONSTRAINT a1cs_unique_patient_id_date;
          ALTER TABLE acrs
            DROP CONSTRAINT acrs_unique_patient_id_date;
          ALTER TABLE bmis
            DROP CONSTRAINT bmis_unique_patient_id_date;
          ALTER TABLE cholesterols
            DROP CONSTRAINT cholesterols_unique_patient_id_date;
          ALTER TABLE ckd_stages
            DROP CONSTRAINT ckd_stages_unique_patient_id_date;
          ALTER TABLE eye_exams
            DROP CONSTRAINT eye_exams_unique_patient_id_date;
          ALTER TABLE flus
            DROP CONSTRAINT flus_unique_patient_id_date;
          ALTER TABLE foot_exams
            DROP CONSTRAINT foot_exams_unique_patient_id_date;
          ALTER TABLE livers
            DROP CONSTRAINT livers_unique_patient_id_date;
          ALTER TABLE pneumonias
            DROP CONSTRAINT pneumonias_unique_patient_id_date;
          ALTER TABLE renals
            DROP CONSTRAINT renals_unique_patient_id_date;
        SQL
      end
    end
  end
end
