class RemoveDescriptionFromCartProducts < ActiveRecord::Migration
  def change
  	remove_column  :cart_products, :description, :string
  end
end
