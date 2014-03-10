class AddUnitsToOldValueColumnNames < ActiveRecord::Migration
  def change
    rename_column :acrs, :acr, :acr_in_mcg_alb_per_mg_cr
    rename_column :renals, :bun, :bun_in_mg_per_dl
    rename_column :renals, :creatinine, :creatinine_in_mg_per_dl
  end
end
