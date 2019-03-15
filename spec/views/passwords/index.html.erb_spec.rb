require 'rails_helper'

RSpec.describe "passwords/index", type: :view do
  before(:each) do
    @passwords = assign(:passwords, create_list(:password, 2))
    @passwords.first.user.confirm
    sign_in(@passwords.first.user)
  end

  it "renders a list of passwords" do
    render
  end
end
