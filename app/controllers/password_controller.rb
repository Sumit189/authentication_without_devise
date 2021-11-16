class PasswordController < ApplicationController
  before_action :check_logged_in, except: [:forget_pass]

  def check_logged_in
    if session[:user].nil?
      redirect_to :controller => :authenticate, :action => :login
    end
  end

  def forget_pass
    if request.post?
      @user = User.find_by_email(params[:email])
      if @user
        rp = gen_random_pass
        puts "New Pass: #{rp}"
        @user.update(:password_ => rp)
        ResetPasswordMailer.with(user: @user, gen_pass: rp).reset_password.deliver_now
        redirect_to authenticate_login_path, notice: "New password is sent to your email."
      else
        render forget_pass, notice: "Email not found."
      end
      end
    end

  def gen_random_pass
    SecureRandom.base58(8)
  end

  def reset_password
    if request.post?
      update
    end
  end

  def update
      @user = User.find(session[:user])
      if @user
        if @user.authenticate(@user.email, params[:current_password])
          @user.update(:password_ => params[:password_])
          NotifierMailer.with(user: @user).pass_changed.deliver_now
          flash[:notice] = "Password updated successfully"
          redirect_to :action => :my_profile, :controller => :home
        else
          flash[:alert] = "Current Password is invalid"
          render :reset_password
        end
      else
        flash[:alert] = "User doesn't exists"
        render :reset_password
      end
  end

end
