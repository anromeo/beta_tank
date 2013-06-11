module Users
  class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
    def twitter
      @user = User.find_or_create_for_twitter(env["omniauth.auth"])
      flash[:notice] = "Signed in with Twitter successfully."
      sign_in @user, :event => :authentication
      redirect_to betas_path
    end
  end
end
