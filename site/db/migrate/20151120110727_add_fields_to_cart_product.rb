class AddFieldsToCartProduct < ActiveRecord::Migration
  def change
  	add_column :cart_products, :user_id, :integer
  end
end
