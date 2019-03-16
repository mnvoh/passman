require 'rails_helper'

RSpec.describe "passwords/edit", type: :view do
  before(:each) do
    @password = assign(:password, create(:password))
    @password.user.confirm
    sign_in(@password.user)
  end

  it "renders the edit password form" do
    render

    assert_select "form[action=?][method=?]", password_path(@password), "post" do
    end
  end
end
