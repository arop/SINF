class CartProductController < ApplicationController
	before_filter :authenticate_user!

	def add
		
		@cart_product = CartProduct.new(cart_product_params)
		@cart_product.user_id = current_user.id

		if @cart_product.save
			redirect_to cart_index_url
		end

	end

	private
	def cart_product_params
		params.permit(:id_produto, :quantity)
	end

end
