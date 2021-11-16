class HomeController < ApplicationController
  before_action :check_logged_in

  def check_logged_in
    if session[:user].nil?
      redirect_to :controller => :authenticate, :action => :login
    end
  end

  def my_profile
    @user = User.find(session[:user])
  end

  def update
    @user = User.find(session[:user])
      if @user.update(update_params)
        flash[:notice] = "Profile updated successfully"
        render :my_profile
      else
        flash[:alert] = "Profile update failed"
        render :my_profile
      end
    end

  def logout
    session[:user] = nil
    redirect_to :action => :login, :controller => :authenticate
  end

  def destroy
    @user = User.find(session[:user])
    NotifierMailer.with(user: @user).delete_account.deliver_later
    @user.destroy
    session[:user] = nil
    redirect_to :action => :login, :controller => :authenticate
  end

  private
  def update_params
    params.require(:user).permit(:first_name, :last_name, :date_of_birth, :mobile_number, :image)
  end
end
