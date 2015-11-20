class AddFieldsToCart < ActiveRecord::Migration
  def change
  	add_reference :carts, :user, index: true, foreign_key: true
  end
end
