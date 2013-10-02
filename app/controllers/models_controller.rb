class ModelsController < ApplicationController
  
  def visor
    @models = Model.all
  end

  def index
  	@models = Model.all
  end

  def new
  	@model = Model.new
  end

  def create
  	@model = Model.new(model_params)
    if @model.save
      flash[:model_id] = @model.id
      redirect_to new_model_path
    else
      render :action => "new"
    end
  end

  private

    def model_params
      params.require(:model).permit(:species, :url, :model_date, :rating, :author)
    end
end
