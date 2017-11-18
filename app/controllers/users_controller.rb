class UsersController < ApplicationController

  def index
    @users = User.all
  end
  def destroy
    @user = User.find(params[:id])
    @user.listings.each do |l|
      l.update_attribute(:user_id, 1)
    end
    @user.destroy
  end

end
