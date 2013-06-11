class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :set_locale

  def after_sign_in_path_for(users)
    sign_in_url = url_for(:action => 'new',
                          :controller => 'sessions',
                          :protocol => '/')
    if request.referer == sign_in_url
      super
    else
      betas_path
    end
  end

private

  def set_locale
    I18n.locale = params[:locale] if params[:locale].present?
  end

  def default_url_options(options={})
    {locale: I18n.locale}
  end
end
