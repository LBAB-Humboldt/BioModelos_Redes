class RatingsController < ApplicationController

	def create
		@rating = Rating.new(rating_params)
		if @rating.save
			respond_to do |format|
				format.js
			end
		end
	end

	def update
		@rating = Rating.find(params[:id])
		@model = @rating.model

		if @rating.update_attributes(score: params[:score])
			respond_to do |format|
				format.js
			end
		end
	end

	def rate_model
		@rating = Rating.where(:model_id => params[:mid], :user_id => current_user.id).first
		if @rating.blank?
			Rating.create({:model_id => params[:mid], :user_id => current_user.id, :score => params[:score]})
		else
			Rating.update(@rating.id, {:score => params[:score]})
		end

		respond_to do |format|
			format.js
		end
	end

	private

    	def rating_params
      		params.require(:rating).permit(:model_id, :user_id, :score)
    	end

end