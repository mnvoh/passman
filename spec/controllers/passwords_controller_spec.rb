require 'rails_helper'

RSpec.describe PasswordsController, type: :controller do

  let(:password) do
    password = create(:password)
    password.user.confirm
    password
  end

  let(:valid_attributes) { {
    master_password: TEST_PASSWORD,
    repeat_master_password: TEST_PASSWORD,
    password: {
      title: 'test',
      url: 'https://example.com/',
      password: '123123',
      description: 'test',
    }
  } }

  before(:each) do
    @request.env['devise.mapping'] = Devise.mappings[:user]
    user = password.user
    sign_in(user)
  end

  describe "GET #index" do
    it "returns a success response" do
      get :index
      expect(response).to be_successful
    end
  end

  describe "GET #unlock" do
    it "returns a success response" do
      get :unlock, params: {id: password.id}
      expect(response).to be_successful
    end
  end

  describe "POST #show" do
    it "returns a success response" do
      post :show, params: {id: password.id, master_password: TEST_PASSWORD}
      expect(response).to be_successful
    end
  end

  describe "GET #new" do
    it "returns a success response" do
      get :new
      expect(response).to be_successful
    end
  end

  describe "POST #edit" do
    it "returns a success response" do
      post :edit, params: {id: password.id, master_password: TEST_PASSWORD}
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    it "creates a new Password" do
      post :create, params: valid_attributes
      expect(response).to redirect_to(Password.last)
    end
  end

  describe "PUT #update" do
    it "updates the requested password" do
      new_attributes = valid_attributes
      new_attributes[:password][:title] = 'new_title'
      new_attributes[:id] = password.id
      put :update, params: new_attributes
      password.reload
      expect(password.title).to eq('new_title')
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested password" do
      expect {
        delete :destroy, params: {id: password.to_param}
      }.to change(Password, :count).by(-1)
    end
  end
end
