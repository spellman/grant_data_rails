class CreateTestosterones < ActiveRecord::Migration
  def change
    reversible do |dir|
      dir.up do
        create_table :testosterones do |t|
          t.references :patient, index: true
          t.date :date, null: false
          t.integer :testosterone_in_ng_per_dl, null: false
        end

        execute <<-SQL
          ALTER TABLE testosterones
            ADD CONSTRAINT testosterones_unique_patient_id_date UNIQUE (patient_id, date);
          ALTER TABLE testosterones
            ADD FOREIGN KEY (patient_id) REFERENCES patients(id) ON DELETE CASCADE
        SQL
      end

      dir.down do
        drop_table :testosterones
      end
    end
  end
end
