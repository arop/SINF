class EncomendaController < ApplicationController
  def new
  end

  def show
  	@encomenda_id = params[:id]
  end

  def getUser
  	user = User.where(entidade: params[:id]).take
  	if user.nil?
  		render :json => {:success => false }
  	else
  		render :json => {:success => true , :user => user}
  	end
  end
end
