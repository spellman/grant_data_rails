class ChangePatientColumns < ActiveRecord::Migration
  def change
    remove_column :patients, :name
    add_column :patients, :patient_id, :integer, null: false
    add_column :patients, :birthdate, :date
    add_column :patients, :smoker, :boolean
    add_column :patients, :etoh, :boolean
  end
end
