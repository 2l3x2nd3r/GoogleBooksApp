# The first thing you need to configure is which modules you need in your app.
# The default is nothing which will include only core features (password encryption, login/logout).
# Available submodules are: :user_activation, :http_basic_auth, :remember_me,
# :reset_password, :session_timeout, :brute_force_protection, :activity_logging, :external
Rails.application.config.sorcery.submodules = [:core, :user_activation, :remember_me, :reset_password, :activity_logging]

# Here you can configure each submodule's features.
Rails.application.config.sorcery.configure do |config|

  config.user_config do |user|
    
    user.username_attribute_names = [:username, :email]

    user.downcase_username_before_authenticating = true

    user.user_activation_mailer = UserMailer

    user.activation_success_email_method_name = nil

    user.reset_password_mailer = UserMailer

  end

  # This line must come after the 'user config' block.
  # Define which model authenticates with sorcery.
  config.user_class = "User"
end
