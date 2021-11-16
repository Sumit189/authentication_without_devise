class SignupMailer < ApplicationMailer
  def new_user_register
    @user = params[:user]
    mail(to: @user.email, subject: 'Thank you for registering')
  end
end
