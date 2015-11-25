class CategoriaController < ApplicationController
	def index
		cats = params[:id].split("/")
		if cats.length > 1
			@id_subcategoria = cats[1]
		end
		@id_categoria = cats[0]	
	end
end
