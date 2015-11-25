class AddCodPostalToUser < ActiveRecord::Migration
  def change
    add_column :users, :codigo, :string
    add_column :users, :localidade, :string
  end
end
