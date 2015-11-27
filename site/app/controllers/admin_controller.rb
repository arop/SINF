class AdminController < ApplicationController
	
  def new
  end

  def show
  end

  def index
  	require 'date'
  	@mes = Date.today.strftime("%m")
  	@ano = Date.today.strftime("%Y")

  end
end
