class ApplicationController < ActionController::Base
  before_action :prepare_generator

  private

    def verify_login
      unless user_signed_in?
        flash[:alert] = 'You must login before viewing that page!'
        redirect_to new_user_session_path
      end
    end

    def prepare_generator
      if user_signed_in?
        if current_user.preferences.nil?
          current_user.preferences = {
            'generator_lower': true,
            'generator_upper': true,
            'generator_numbers': true,
            'generator_symbols': true,
            'generator_length': 12
          }
          current_user.save
        end
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
