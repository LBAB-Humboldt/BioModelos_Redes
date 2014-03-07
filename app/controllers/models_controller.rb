class ModelsController < ApplicationController
  
  def visor
    @review = Review.new
  end

  def index
  	@models = Model.all

    respond_to do |format|
      format.html # show_rec_horses.html.erb
      format.js   # show_rec_horses.js.erb
    end
  end

  def new
  	@model = Model.new
  end

  def create
  	@model = Model.new(model_params)
    if @model.save
      flash[:model_id] = 'Model created!!!'
      redirect_to new_model_path
    else
      render :action => "new"
    end
  end

  def download_model
    respond_to do |format|
      format.js {}
      format.html {send_file Rails.root.join('public/kmz/'+ Model.find(params[:m_id]).img_url.split('.').first + '.kmz'), :type => 'application/octet-stream', :disposition => 'attachment'}
    end
  end

  private

    def model_params
      params.require(:model).permit(:species_id, :img_url, :model_date, :rating, :author, :description)
    end
end