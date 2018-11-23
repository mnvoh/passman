class MainController < ApplicationController
  layout "main"

  def index
    if user_signed_in?
      redirect_to passwords_path
    end
  end

  def tos
  end

  def privacy_policy
  end

  def about
  end
end
