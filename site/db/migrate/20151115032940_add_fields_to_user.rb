class AddFieldsToUser < ActiveRecord::Migration
  def change
	add_column :users, :nome, :string
  	add_column :users, :nif, :integer
	add_column :users, :morada, :string
	add_column :users, :moeda, :string
  end
end
