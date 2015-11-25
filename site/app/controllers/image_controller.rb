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

  def productImg
    @img = Imagem.where(idProduto: params[:id]).take
    render :json => @img
  end

  def destroy
    @img = Imagem.find(params[:id])
    @img.destroy

    render :json => @img
  end


  private
  def img_params
	params.require(:imagem).permit(:image,:idProduto)
  end
end
