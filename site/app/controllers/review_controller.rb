class ReviewController < ApplicationController
	def create
 		@review = Review.new(review_params)
        @review.user_id = current_user.id

        if @review.save
            render :json => @review
        else
            render :json => @review.errors
        end
	end

	def destroy

	end

	private
	def review_params
		params.require(:review).permit(:comment,:rating,:produto_id)
	end

end
