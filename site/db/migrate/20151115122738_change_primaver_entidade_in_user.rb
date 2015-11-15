class ChangePrimaverEntidadeInUser < ActiveRecord::Migration
  def change
  	add_column :users, :entidade, :string
  	remove_column :users, :primavera_id
  	drop_table :profiles
  end
end
