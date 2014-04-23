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

    if params[:species_id].blank?
      @species = nil
    else
      @species = Species.find(params[:species_id])
      @models = Model.where(:species_id => params[:species_id], current: true).limit(10)
      @all_comments = @species.root_comments.order('created_at desc')

      arr = []
      @ratings = Hash.new 

      @models.each do |m|
        arr.push(m.id)
        if user_signed_in?
          @rating = Rating.where(model_id: m.id, user_id: current_user.id).first
          @ratings[m.id] = @rating.blank? ? 0 : @rating.score
        end
      end

      @species_reviews = Review.where({ model_id: arr})

      if user_signed_in?
        @new_comment = Comment.build_from(@species, current_user.id, '')
      end
    end

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

  def download_metadata
    respond_to do |format|
      format.js {}
      format.html { send_file Rails.root.join('public/metadata/'+ Species.find(params[:s_id]).ocurrence_records_url.split('.').first + '.html'), :type => 'text/html', :disposition => 'attachment' }
    end
  end

  def comment_point
    @point_comment = PointComment.new

    respond_to do |format|
      format.js
    end
  end

  def create_comment_point
    @point_comment = PointComment.new(point_comment_params)
    if @point_comment.save
      flash[:success] = 'Anotación guardada con éxito.'
    else
      flash[:error] = 'Ha ocurrido un error mientras se guardaba la anotación.'
    end

     respond_to do |format|
        format.html
        format.js
     end
  end

  def workshop_test
    @workshop_test = WorkshopTest.new

    respond_to do |format|
      format.js
    end
  end

  def create_workshop_test
    @workshop_test = WorkshopTest.new(workshop_test_params)

    if @workshop_test.save
      flash[:success] = 'Anotación guardada con éxito.'
    else
      flash[:error] = 'Ha ocurrido un error mientras se guardaba la anotación.'
    end

     respond_to do |format|
        format.html
        format.js
     end
  end

  def update
  end

  private

    def species_params
      params.require(:species).permit(:class_id, :sci_name, :order, :family, :sib_url, :ocurrence_records)
    end

    def point_comment_params
      params.require(:point_comment).permit(:user_id, :species_id, :lat, :lon, :wrong_id, :geo_problem, :comment)
    end

    def workshop_test_params
      params.require(:workshop_test).permit(:user_id, :species_id, :lat, :lon, :min_ocurrence, :max_ocurrence, :best_prob_ocurrence, :certainty_true_value)
    end
end
