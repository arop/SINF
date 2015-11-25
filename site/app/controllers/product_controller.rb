class ProductController < ApplicationController
	def new
	end

	def show
		@product_id = params[:id]
		if Imagem.where(idProduto: @product_id).take.nil?
			@img = nil
		else @img = Imagem.where(idProduto: @product_id).take.image
		end
	end
end
