require 'rails_helper'

RSpec.describe MainController, type: :controller do
  context '#index' do
    it 'should show the home page for guests' do
      get :index 
      expect(response.status).to eq(200)
    end

    it 'should redirect for authenticated users' do
      user = create(:user)
      sign_in user
      get :index
      expect(response.status).to eq(302)
    end
  end
end
