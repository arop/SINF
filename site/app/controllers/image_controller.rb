class ImageController < ApplicationController
  def new
  end

  def create
	@img = Imagem.new(img_params)

	if @img.save
        render :json => @img
   	else 
       	render :json => @img.errors
   	end
  end

  private
  def img_params
	params.require(:imagem).permit(:image,:idProduto)
  end
end
