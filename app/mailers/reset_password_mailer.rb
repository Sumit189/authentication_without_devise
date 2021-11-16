class ResetPasswordMailer < ApplicationMailer
  def reset_password
    @user = params[:user]
    @pass = params[:gen_pass]
    mail(to: @user.email, subject: 'Password has been reset')
  end
end
