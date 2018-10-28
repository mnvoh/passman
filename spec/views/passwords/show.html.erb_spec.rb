require 'rails_helper'

RSpec.describe "passwords/show", type: :view do
  before(:each) do
    @password = assign(:password, Password.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
