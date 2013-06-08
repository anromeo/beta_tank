class HomeController <  ApplicationController
  layout false

  def index
    if user_signed_in?
      redirect_to betas_path
    end
  end
end