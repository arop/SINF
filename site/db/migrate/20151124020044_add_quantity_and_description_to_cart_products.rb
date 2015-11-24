class AddQuantityAndDescriptionToCartProducts < ActiveRecord::Migration
	def change
	    add_column :cart_products, :quantity, :integer
	    add_column :cart_products, :description, :string
	end
end
