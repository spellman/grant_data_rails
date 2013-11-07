class CreatePatients < ActiveRecord::Migration
  def change
    create_table :patients do |t|
      t.string :name,       null: false
      t.string :diagnosis , null: false
    end
  end
end
