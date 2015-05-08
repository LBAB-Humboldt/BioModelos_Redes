class SpeciesGroupsController < ApplicationController
  def index
  end

  def update
  end

  def create
    @species_group = SpeciesGroup.new
    species_params=params[:species_group]
    @species_group.group_id=species_params[:group_id]
    @species_group.species_id=species_params[:species_id]
    @species_group.species_group_state_id=species_params[:species_group_state_id]
    if @species_group.save
      redirect_to group_path(id:species_params[:group_id])
    end
    #render plain: params[:species_group].inspect
  end

end
