class DeleteMoedaFromUser < ActiveRecord::Migration
  def change
  	remove_column :users, :moeda
  end
end
