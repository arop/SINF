class AddPrimaveraIdToUser < ActiveRecord::Migration
  def change
	add_column :users, :primavera_id, :integer
  end
end
