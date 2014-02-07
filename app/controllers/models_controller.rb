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

  def search
    @models = Model.search params[:query]

    respond_to do |format|
      format.html # show_rec_horses.html.erb
      format.js   # show_rec_horses.js.erb
    end
  end

  def download_model
    send_file Rails.root.join('public/'+ Model.find(params[:m_id]).img_url), :type => 'image/png', :disposition => 'attachment'
  end

  private

    def model_params
      params.require(:model).permit(:species_id, :img_url, :model_date, :rating, :author, :description)
    end
end
