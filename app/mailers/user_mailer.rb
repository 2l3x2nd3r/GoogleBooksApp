class UserMailer < ApplicationMailer
  default from: "no-reply@developmentteam.com"

 def activation_needed_email(user)
    @user, @url = user, "piratebooks.herokuapp.com/confirmations/#{user.activation_token}"
    mail to: user.email, subject: 'Sucessfully register'
  end

   def reset_password_email(user)
    @user, @url = user, "piratebooks.herokuapp.com/password_resets/#{user.reset_password_token}/edit"
    mail to: user.email, subject: 'Recover password'
  end  
end

# googlebooks.herokuapp.com