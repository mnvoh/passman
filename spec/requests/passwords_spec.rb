require 'rails_helper'

RSpec.describe "Passwords", type: :request do
  describe "GET /passwords" do
    it "works! (now write some real specs)" do
      get passwords_path
      expect(response).to have_http_status(200)
    end
  end
end
