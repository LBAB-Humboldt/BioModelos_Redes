class GroupsController < ApplicationController
  def index
    @groups = Group.where(:group_state_id => 1)
  end

  def show
    @group = Group.find(params[:id])
    @species_groups = SpeciesGroup.where(:group_id => @group.id, :species_group_state_id => 1);
    puts @species_groups.inspect
    @is_member = false
    @is_admin = false
    if user_signed_in?
      @user_group = GroupUser.find_by_group_id_and_user_id(@group.id, current_user.id)
      if @user_group
        if @user_group.group_user_state_id==1
          @is_member=true
        end
        if @user_group.is_admin
          @is_admin = true
        end
      end
    end
  end

  def update
    group_params =params[:group]
    @group = Group.find(params[:id])
    @group.name=group_params[:name]
    @group.description=group_params[:description]
    @group.logo=group_params[:logo]
    @group.link=group_params[:link]
    @group.email=group_params[:email]
    if @group.save
      @message = "Cambios Guardados con exito"
    else
      @message = "Ocurrrió un error al guardar datos"
    end
    redirect_to groups_show_path(params)
  end
end
