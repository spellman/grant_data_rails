class CreateMeasurements < ActiveRecord::Migration
  def change
    reversible do |dir|
      dir.up do
        create_table :measurements do |t|
          t.references :patient, index: true
          t.date :date, null: false
          t.decimal :weight_in_pounds, precision: 5, scale: 2
          t.decimal :height_in_inches, precision: 5, scale: 2
          t.decimal :waist_circumference_in_inches, precision: 5, scale: 2
        end

        execute <<-SQL
          ALTER TABLE measurements
            ADD CONSTRAINT measurements_unique_patient_id_date UNIQUE (patient_id, date);
          ALTER TABLE measurements
            ADD FOREIGN KEY (patient_id) REFERENCES patients(id) ON DELETE CASCADE
        SQL
      end

      dir.down do
        drop_table :measurements
      end
    end
  end
end
