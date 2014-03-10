class CholesterolsRenameColumns < ActiveRecord::Migration
  def change
    rename_column :cholesterols, :tc, :total_cholesterol_in_mg_per_dl
    rename_column :cholesterols, :tg, :triglycerides_in_mg_per_dl
    rename_column :cholesterols, :hdl, :hdl_in_mg_per_dl
    rename_column :cholesterols, :ldl, :ldl_in_mg_per_dl
  end
end
