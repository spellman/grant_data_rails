class RenameRenalsToBunAndCreatinines < ActiveRecord::Migration
  def change
    rename_table :renals, :bun_and_creatinines
  end
end
