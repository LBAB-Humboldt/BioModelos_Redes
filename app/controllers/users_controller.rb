class UsersController < ApplicationController
  def index
  end

  def new
	@groups = Groups.where(:group_state_id = >1)
  end

  def show
  	@user = User.find(params[:id])
    @users_by_reviews = @user.users_most_reviews

    if @user.blank?
      @reviews = nil
    else 
      @reviews = Review.where(:user_id => @user.id).order("created_at DESC").limit(15)
    end
  end

  def edit_profile
    respond_to do |format|
      format.js
    end
  end

  def create
    puts sign_up_params.inspect
    build_resource(sign_up_params)

    resource_saved = resource.save
    yield resource if block_given?
    if resource_saved
      if resource.active_for_authentication?
        set_flash_message :notice, :signed_up if is_flashing_format?
        sign_up(resource_name, resource)
        respond_with resource, location: after_sign_up_path_for(resource)
      else
        set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_flashing_format?
        expire_data_after_sign_in!
        respond_with resource, location: after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      @validatable = devise_mapping.validatable?
      if @validatable
        @minimum_password_length = resource_class.password_length.min
      end
      respond_with resource
    end
  end

  def update
  end
end
