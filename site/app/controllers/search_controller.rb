class SearchController < ApplicationController

	def index
		@search_query = params[:q]
	end
end
