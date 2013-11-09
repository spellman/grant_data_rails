class AddPatientForeignKeyToRecords < ActiveRecord::Migration
  def change
    reversible do |dir|
      dir.up do
        execute <<-SQL
          ALTER TABLE records
            ADD COLUMN patient_id integer NOT NULL REFERENCES patients ON DELETE CASCADE
        SQL
      end
      dir.down do
        execute <<-SQL
          ALTER TABLE records
            DROP COLUMN patient_id
        SQL
      end
    end
  end
end
