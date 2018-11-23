class MainController < ApplicationController
  layout "main"

  def index
    if user_signed_in?
      redirect_to passwords_path
    end
  end

  def tos
    @page_title = I18n.t('terms_of_service')
  end

  def privacy_policy
    @page_title = I18n.t('privacy_policy')
  end

  def about
    @page_title = I18n.t('about')
  end

  def privacy_policy
  end

  def about
  end

  def privacy_policy
  end

  def about
  end
end
