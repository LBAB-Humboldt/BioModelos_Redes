class ReviewsController < ApplicationController
  def index
    @reviews = Review.all
  end
  
  def show

  end

  def create

    @review = Review.new(review_params)

    if @review.save
      flash[:success] = 'Anotación guardada con éxito.'
    else
      flash[:error] = 'Ha ocurrido un error mientras se guardaba la anotación.'
    end
    respond_to do |format|
        format.js
    end
  end

  def destroy
    @review = Review.find(params[:id])

    if @review.destroy
        redirect_to user_path(@review.user_id)
      else
        render :js => "alert('Error eliminando edición');"
      end
  end

  def reviews_by_species
    @species = Species.find(params[:id])
    @models = Model.where(:species_id => params[:id], current: true)

    arr = []
    @models.each do |m|
        arr.push(m.id)
    end

    @species_reviews = Review.where({ model_id: arr}).order("created_at DESC")


    respond_to do |format|
        format.js
    end
  end

  private

    def review_params
      params.require(:review).permit(:user_id, :model_id, :geoJSON)
    end

end

