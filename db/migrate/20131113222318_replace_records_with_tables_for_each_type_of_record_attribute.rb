class ReplaceRecordsWithTablesForEachTypeOfRecordAttribute < ActiveRecord::Migration
  def change
    drop_table :records

    create_table :bmis do |t|
      t.references :patient, index: true
      t.datetime   :date, null: false
      t.decimal    :bmi
      t.timestamps
    end

    create_table :a1cs do |t|
      t.references :patient, index: true
      t.datetime   :date, null: false
      t.decimal    :a1c
      t.timestamps
    end

    create_table :cholesterols do |t|
      t.references :patient, index: true
      t.datetime   :date, null: false
      t.integer    :tc
      t.integer    :tg
      t.integer    :hdl
      t.integer    :ldl
      t.timestamps
    end

    create_table :acrs do |t|
      t.references :patient, index: true
      t.datetime   :date, null: false
      t.integer    :acr
      t.timestamps
    end

    create_table :renals do |t|
      t.references :patient, index: true
      t.datetime   :date, null: false
      t.integer    :bun
      t.integer    :creatinine
      t.timestamps
    end

    create_table :ckd_stages do |t|
      t.references :patient, index: true
      t.datetime   :date, null: false
      t.integer    :ckd_stage
      t.timestamps
    end

    create_table :livers do |t|
      t.references :patient, index: true
      t.datetime   :date, null: false
      t.integer    :ast
      t.integer    :alt
      t.timestamps
    end

    create_table :eye_exams do |t|
      t.references :patient, index: true
      t.datetime   :date, null: false
      t.timestamps
    end

    create_table :foot_exams do |t|
      t.references :patient, index: true
      t.datetime   :date, null: false
      t.timestamps
    end

    create_table :flus do |t|
      t.references :patient, index: true
      t.datetime   :date, null: false
      t.timestamps
    end

    create_table :pneumonias do |t|
      t.references :patient, index: true
      t.datetime   :date, null: false
      t.timestamps
    end

    execute <<-SQL
      ALTER TABLE bmis
        ADD FOREIGN KEY (patient_id) REFERENCES patients(id) ON DELETE CASCADE
    SQL

    execute <<-SQL
      ALTER TABLE a1cs
        ADD FOREIGN KEY (patient_id) REFERENCES patients(id) ON DELETE CASCADE
    SQL

    execute <<-SQL
      ALTER TABLE cholesterols
        ADD FOREIGN KEY (patient_id) REFERENCES patients(id) ON DELETE CASCADE
    SQL

    execute <<-SQL
      ALTER TABLE acrs
        ADD FOREIGN KEY (patient_id) REFERENCES patients(id) ON DELETE CASCADE
    SQL

    execute <<-SQL
      ALTER TABLE renals
        ADD FOREIGN KEY (patient_id) REFERENCES patients(id) ON DELETE CASCADE
    SQL

    execute <<-SQL
      ALTER TABLE ckd_stages
        ADD FOREIGN KEY (patient_id) REFERENCES patients(id) ON DELETE CASCADE
    SQL
    
    execute <<-SQL
      ALTER TABLE livers
        ADD FOREIGN KEY (patient_id) REFERENCES patients(id) ON DELETE CASCADE
    SQL

    execute <<-SQL
      ALTER TABLE eye_exams
        ADD FOREIGN KEY (patient_id) REFERENCES patients(id) ON DELETE CASCADE
    SQL

    execute <<-SQL
      ALTER TABLE foot_exams
        ADD FOREIGN KEY (patient_id) REFERENCES patients(id) ON DELETE CASCADE
    SQL

    execute <<-SQL
      ALTER TABLE flus
        ADD FOREIGN KEY (patient_id) REFERENCES patients(id) ON DELETE CASCADE
    SQL
    
    execute <<-SQL
      ALTER TABLE pneumonias
        ADD FOREIGN KEY (patient_id) REFERENCES patients(id) ON DELETE CASCADE
    SQL
  end
end
