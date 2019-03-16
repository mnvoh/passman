require 'rails_helper'

RSpec.describe "passwords/show", type: :view do
  before(:each) do
    @password = assign(:password, create(:password))
    @password.user.confirm
    sign_in(@password.user)
    @decrypted_data = @password.decrypt_data(TEST_PASSWORD)
  end

  it "renders attributes in <p>" do
    render
  end
end
