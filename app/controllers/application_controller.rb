class ApplicationController < ActionController::Base
  before_action :verify_login

  private

    def verify_login
      exceptions = [
        /main#[a-z]+/,
        /sessions#[a-z]+/,
      ]
      action = "#{controller_name}##{action_name}"
      
      unless user_signed_in? || exceptions.any? { |r| r.match? action }
        flash[:alert] = 'You must login before viewing that page!'
        redirect_to new_user_session_path
      end
    end
end
