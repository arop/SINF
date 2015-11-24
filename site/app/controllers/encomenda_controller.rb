class EncomendaController < ApplicationController
  def new
  end

  def show
  	@encomenda_id = params[:id]
  end
end
