class UsersController < ApplicationController
  def index
  end

  def new
  	respond_to do |format|
      format.html # show_rec_horses.html.erb
      format.js   # show_rec_horses.js.erb
    end
  end

  def show
  	@user = User.find(params[:id])
  end

  def edit
  end

  def update
  end
end
