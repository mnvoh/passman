class MainController < ApplicationController
  layout "main"

  def index
    render text: '', layout: true
  end
end
