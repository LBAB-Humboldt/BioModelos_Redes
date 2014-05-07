class UsersController < ApplicationController
  def index
  end

  def new
  end

  def show
  	@user = User.find(params[:id])
    @users_by_reviews = @user.users_most_reviews

    if @user.blank?
      @reviews = nil
    else 
      @reviews = Review.where(:user_id => @user.id).limit(15)
    end
  end

  def edit_profile
    respond_to do |format|
      format.js
    end
  end

  def update
  end
end
