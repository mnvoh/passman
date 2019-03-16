require 'rails_helper'

RSpec.describe SecureNotesController, type: :controller do

  let(:valid_attributes) {
    skip("Add a hash of attributes valid for your model")
  }

  let(:secure_note) {
    secure_note = create(:secure_note)
    secure_note.user.confirm
    secure_note
  }

  let(:valid_attributes) { {
    master_password: TEST_PASSWORD,
    repeat_master_password: TEST_PASSWORD,
    secure_note: {
      title: 'test',
      note: 'test',
    }
  } }

  before(:each) do
    @request.env['devise.mapping'] = Devise.mappings[:user]
    user = secure_note.user
    sign_in(user)
  end

  describe "GET #index" do
    it "returns a success response" do
      get :index, params: {}
      expect(response).to be_successful
    end
  end

  describe "POST #show" do
    it "returns a success response" do
      post :show, params: {id: secure_note.to_param, master_password: TEST_PASSWORD}
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
      post :edit, params: {id: secure_note.to_param, master_password: TEST_PASSWORD}
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new SecureNote" do
        expect {
          post :create, params: valid_attributes
        }.to change(SecureNote, :count).by(1)
      end

      it "redirects to the created secure_note" do
        post :create, params: valid_attributes
        expect(response).to redirect_to(SecureNote.last)
      end
    end
  end

  describe "PUT #update" do
    it "updates the requested secure_note" do
      new_attributes = valid_attributes
      new_attributes[:id] = secure_note.id
      new_attributes[:secure_note][:title] = 'updated'
      put :update, params: new_attributes
      secure_note.reload

      expect(secure_note.title).to eq('updated')
    end

    it "redirects to the secure_note" do
      new_attributes = valid_attributes
      new_attributes[:id] = secure_note.id
      new_attributes[:secure_note][:title] = 'updated'
      put :update, params: new_attributes
      expect(response).to redirect_to(secure_note)
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested secure_note" do
      expect {
        delete :destroy, params: {id: secure_note.to_param}
      }.to change(SecureNote, :count).by(-1)
    end
  end
end
