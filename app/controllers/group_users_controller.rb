class GroupUsersController < ApplicationController
  def create

    group_user = GroupUser.new
    group_user.group_id=params[:group_id]
    group_user.user_id=current_user.id
    @return = false
    if group_user.save
      @return = true
    end
  end

  def update
  end
end
