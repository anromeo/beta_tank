module Users
  class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
    def twitter
      @user = User.find_or_create_for_twitter(env["omniauth.auth"])
      if @user.persisted?
        flash[:notice] = "Signed in with Twitter successfully."
        sign_in @user, :event => :authentication
        redirect_to betas_path
      else
        redirect_to new_user_registration_path
      end
    end
  end
end
