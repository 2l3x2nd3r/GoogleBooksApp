# ActionMailer::Base.smtp_settings = {
#   address: "smtp.gmail.com",
#   port: 587,
#   domain: "gmail.com",
#   user_name: "alextab93",
#   password: "1045717291",
#   authentication: "plain",
#   enable_starttls_auto: true
# }
ActionMailer::Base.smtp_settings = {
    address:        "smtp.mandrillapp.com",
    port:            587,
    enable_starttls_auto: true,
    user_name:      'alextab93@gmail.com',
    password:       '3gJidZ0VFHjreoxa3yL9KQ',
    domain:         'heroku.com',
    authentication: "login"
  }
ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.default charset: "utf-8"