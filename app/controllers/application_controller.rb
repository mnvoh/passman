class ApplicationController < ActionController::Base
  before_action :verify_login
  before_action :prepare_generator

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

    def prepare_generator
      if user_signed_in?
        @generator_available = true
        @generator_lower = current_user.preferences['generator_lower'] || true
        @generator_upper = current_user.preferences['generator_upper'] || true
        @generator_numbers = current_user.preferences['generator_numbers'] || true
        @generator_symbols = current_user.preferences['generator_symbols'] || true
        @generator_length = current_user.preferences['generator_length'] || 12
      else
        @generator_available = false
      end
    end
end
