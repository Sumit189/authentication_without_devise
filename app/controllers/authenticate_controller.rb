class AuthenticateController < ApplicationController
  def signup
    @user = User.new
    if request.post?
      @user = User.new(users_param)
      if @user.save
        SignupMailer.with(user: @user).new_user_register.deliver_later
        flash[:notice] = "User created successfully"
        redirect_to :action => "login"
      else
        flash[:alert] = "User not created"
        render  :signup
      end
    end
  end

  def login
    if request.post?
      @user = User.find_by_email(params[:email])
      if !@user.nil?
        if @user.authenticate(params[:email], params[:password])
          session[:user] = @user.id
          redirect_to :action => :my_profile, :controller => :home
        else
          flash[:alert] = "Email or Password is invalid..."
          redirect_to :action => :login
        end
      else
        flash[:alert] = "User doesn't exists, proceed with Signup"
        redirect_to :action => :login
      end
    end
  end



  private
  def users_param
    params.permit(:first_name, :last_name, :date_of_birth, :mobile_number, :email,:password_ ,:password__confirmation,:password, :image)
  end

end
