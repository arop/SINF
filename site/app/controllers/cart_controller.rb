class CartController < ApplicationController
	before_filter :authenticate_user!
	
	def index
		
	end

	def send_cart_primavera
		# now, do the dirty work
		require 'net/http'
		# get the url that we need to post to
		url = URI.parse('http://localhost:49526/api/docvenda')
		json_headers = {"Content-Type" => "application/json", "Accept" => "application/json"}
		http = Net::HTTP.new(url.host, url.port)
		http.read_timeout = 100 #Default is 60 seconds

		linhasDoc = []
		number_artigos = params[:artigo].length - 1

		(0..number_artigos).each do |i|
			artigo = { 'CodArtigo' => params[:artigo][i] , 'Quantidade' => params[:quantidade][i].to_i}
			linhasDoc.push artigo
		end

		# build the params string
		post_args1 = { 'Entidade' => 'SOFRIO', 'Serie' => 'C', 'LinhasDoc' => linhasDoc }
		# send the request
		response = http.post(url.path, post_args1.to_json, json_headers)
		
		if response.code == '201'
			CartProduct.where(:user_id => current_user.id).destroy_all
			#render :json => {"success" => response.code}
			redirect_to profile_path(current_user.id)
		else
			#render :json => {"erro" => response.code}
			redirect_to cart_path
		end
	end
end
