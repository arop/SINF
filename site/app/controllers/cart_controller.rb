class CartController < ApplicationController
	before_filter :authenticate_user!
	
	def index
		
	end

	def send_cart_primavera
		# now, do the dirty work
		require 'net/http'
		json_headers = {"Content-Type" => "application/json", "Accept" => "application/json"}

		if (current_user.entidade).nil? #se user não tem entidade, nunca fez nenhuma compra
			#criar user no primavera
			entidade = 'SITE2-' + current_user.id.to_s
			user = {'CodCliente' => entidade, 'NomeCliente' => current_user.nome, 'NumContribuinte' => current_user.nif , 
				'Morada' => current_user.morada, 'Localidade' => current_user.localidade, 'CodPostal' => current_user.codigo,
				'Moeda' => 'EUR', 'CondicaoPag' => 1 }

			url2 = URI.parse('http://localhost:49526/api/clientes')
			http2 = Net::HTTP.new(url2.host, url2.port)
			http2.read_timeout = 100 #Default is 60 seconds

			response2 = http2.post(url2.path, user.to_json, json_headers)
			#render :json => {"code" => response2.code, "data" => response2.body}
			if response2.code == '201' #se criou
			 	current_user.entidade = entidade 
			 	current_user.save!
			else #se nao criou
			 	redirect_to cart_path
			end

		end

		#ENVIAR VENDA
		# get the url that we need to post to
		url = URI.parse('http://localhost:49526/api/docvenda')
		http = Net::HTTP.new(url.host, url.port)
		http.read_timeout = 100 #Default is 60 seconds
		linhasDoc = []
		number_artigos = params[:artigo].length - 1
		(0..number_artigos).each do |i|
			artigo = { 'CodArtigo' => params[:artigo][i] , 'Quantidade' => params[:quantidade][i].to_i, 'PVP' => params[:preco][i].to_f}
			linhasDoc.push artigo
		end
		# build the params string
		post_args1 = { 'Entidade' => current_user.entidade , 'Serie' => 'C', 'LinhasDoc' => linhasDoc }
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
