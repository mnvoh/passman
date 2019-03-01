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

  context '#about' do
    it 'should return 200' do
      get :about
      expect(response.status).to eq(200)
    end
  end

  context '#tos' do
    it 'should return 200' do
      get :tos
      expect(response.status).to eq(200)
    end
  end

  context '#privacy_policy' do
    it 'should return 200' do
      get :privacy_policy
      expect(response.status).to eq(200)
    end
  end
end
