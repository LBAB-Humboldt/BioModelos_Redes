class SpeciesController < ApplicationController
  def index
  end

  def autocomplete
    species = Species.search(params[:query], params[:classId])
    result = species.collect do |t|
      { value: t.sci_name, id: t.id }
    end

    render json: result
  end  

  def species_content

    if params[:species_id].blank?
      @species = nil
    else
      @species = Species.find(params[:species_id])
    end

    respond_to do |format|
      format.js
    end
  end

  def species_models

    @species_name = params[:name]
    @models = Model.where(:species_id => params[:id]).limit(4)

    respond_to do |format|
      format.js
    end
  end

  def show
    @species = Species.find(params[:id])
    # render :partial=>'show'

    respond_to do |format|
      # format.html {render :partial => 'show'}
      format.js   # show_rec_horses.js.erb
    end
   
  end

  def new
    @species = Species.new
  end

  def create
    @species = Species.new(species_params)
    if @species.save
      flash[:sci_name] = 'Species created!!!'
      redirect_to new_species_path
    else
      render :action => "new"
    end
  end

  def edit

  end

  def update
  end

  private

    def species_params
      params.require(:species).permit(:class_id, :sci_name, :order, :family, :sib_url, :ocurrence_records)
    end

end
