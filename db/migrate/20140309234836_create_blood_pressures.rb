class CreateBloodPressures < ActiveRecord::Migration
  def change
    reversible do |dir|
      dir.up do
        create_table :blood_pressures do |t|
          t.references :patient, index: true
          t.date :date, null: false
          t.integer :systolic_in_mmhg, null: false
          t.integer :diastolic_in_mmhg, null: false
        end

        execute <<-SQL
          ALTER TABLE blood_pressures
            ADD CONSTRAINT blood_pressures_unique_patient_id_date UNIQUE (patient_id, date);
          ALTER TABLE blood_pressures
            ADD FOREIGN KEY (patient_id) REFERENCES patients(id) ON DELETE CASCADE
        SQL
      end

      dir.down do
        drop_table :blood_pressures
      end
    end
  end
end
