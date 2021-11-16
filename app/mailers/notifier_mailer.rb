class NotifierMailer < ApplicationMailer
  def pass_changed
    @user = params[:user]
    mail(to: @user.email, subject: 'Password Changed')
  end

  def delete_account
    @user = params[:user]
    mail(to: @user.email, subject: 'Account Deleted')
  end
end
