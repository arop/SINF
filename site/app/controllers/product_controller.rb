class ProductController < ApplicationController
	def new
	end

	def show
		@product_id = params[:id]
		if Imagem.where(idProduto: @product_id).take.nil?
			@imgs = nil
		else @imgs = Imagem.where(idProduto: @product_id)
		end

		@desc = ProductDescription.where(idProduto: @product_id).take
	end
end
