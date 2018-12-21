require 'rails_helper'

RSpec.describe "SecureNotes", type: :request do
  describe "GET /secure_notes" do
    it "works! (now write some real specs)" do
      get secure_notes_path
      expect(response).to have_http_status(200)
    end
  end
end
