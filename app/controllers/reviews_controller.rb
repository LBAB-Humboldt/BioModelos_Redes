class ReviewsController < ApplicationController
  def index
    @reviews = Review.all
  end
  
  def show
  end

  def create
    @review = Review.new(review_params)
    
    if @review.save
      flash[:model_id] = 'Review created!!!'
    else
      flash[:model_id] = 'Error!!!'
    end

    redirect_to models_visor_path
    #    flash[:model_id] = 'Review created!!!'
    #    redirect_to models_visor_path
    # else
    #    redirect_to root
    # end

    # respond_to do |format|
    #   format.html { 
    #     @review.save ? redirect_to(@review, :notice => "Su correción ha sido guardada con éxito.") : render "models/visor"
    #   }
    #   format.js
    # end
  end

  private

    def review_params
      params.require(:review).permit(:user_id, :model_id, :geoJSON)
    end

end
