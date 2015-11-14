class ProductController < ApplicationController
	def new
	end

	def show
		@product_id = params[:id]
	end
end
