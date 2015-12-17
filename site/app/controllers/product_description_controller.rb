class ProductDescriptionController < ApplicationController
  def create
  	p params[:product_description][:idProduto]
  	old = ProductDescription.where(:idProduto => params[:product_description][:idProduto]).take
  	if old.nil?
		  @desc = ProductDescription.new(desc_params)
	  else
		  old.description = params[:product_description][:description]
		  @desc = old
	  end
	  if @desc.save
        render :json => @desc
   	else 
       	render :json => @desc.errors
   	end
  end

  def destroy
    @desc = ProductDescription.find(params[:id])
    @desc.destroy

    render :json => @desc
  end

  private
  def desc_params
	  params.require(:product_description).permit(:description,:idProduto)
  end
end
