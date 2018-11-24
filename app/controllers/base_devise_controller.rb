class BaseDeviseController < ApplicationController
  layout 'devise'
  before_action :set_page_title

private

  def set_page_title
    @page_title = controller_name + ' -> ' + action_name
    key = "#{controller_name}##{action_name}"
    case key
    when 'sessions#new'
      @page_title = I18n.t('login')
    when 'registrations#new'
      @page_title = I18n.t('register')
    when 'passwords#new'
      @page_title = I18n.t('recover_password')
    when 'confirmations#new'
      @page_title = I18n.t('resend_confirmation_instructions')
    end
  end
end
