class GroupsController < ApplicationController
  def index
    @groups = Group.where(:group_state_id => 1)
  end

  def show
    @group = Group.find(params[:id])
    @species_groups = SpeciesGroup.where(:group_id => @group.id, :species_group_state_id => 1);
    @pending_species_groups = SpeciesGroup.where(:group_id => @group.id, :species_group_state_id => 2);
    @members = GroupUser.where(:group_id =>  @group.id, :group_user_state_id => 1, :is_admin => false)
    @pending_members = GroupUser.where(:group_id =>  @group.id, :group_user_state_id => 2)
    @group_admins = GroupUser.where(:group_id =>  @group.id, :group_user_state_id => 1, :is_admin => true)
    @species = Species.all
    @user = User.find(current_user.id)
    @users_by_reviews = @user.users_most_reviews
    @species_group = SpeciesGroup.new
    @group_user = GroupUser.new
    @is_member = false
    @is_admin = false
    @text_join = "Unirse al Grupo"
    if user_signed_in?
      @user_group = GroupUser.find_by_group_id_and_user_id(@group.id, current_user.id)
      if @user_group
        case @user_group.group_user_state_id
          when 2
            @text_join = "Pendiente de Aprobación"
          when 1
            @is_member=true
            @text_join = "Abandonar Grupo"
          when 3
            @text_join = "Solicitar Aprobación Nuevamente"
          when 4
            @text_join = "Unirse al grupo Nuevamente"
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
    redirect_to group_path(id:params[:id])
  end
end
