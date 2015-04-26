class UserMailer < ApplicationMailer
  default from: "alextab93@gmail.com"

 def activation_needed_email(user)
    @user, @url = user, "localhost:3000/confirmations/#{user.activation_token}"
    mail to: user.email, subject: 'Sucessfully register'
  end

   def reset_password_email(user)
    @user, @url = user, "localhost:3000/password_resets/#{user.reset_password_token}/edit"
    mail to: user.email, subject: 'Recover password'
  end  
end

# googlebooks.herokuapp.com