require 'rails_helper'

RSpec.describe "passwords/new", type: :view do
  before(:each) do
    assign(:password, Password.new())
  end

  it "renders new password form" do
    render

    assert_select "form[action=?][method=?]", passwords_path, "post" do
    end
  end
end
