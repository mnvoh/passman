require 'rails_helper'

RSpec.describe "passwords/index", type: :view do
  before(:each) do
    assign(:passwords, [
      Password.create!(),
      Password.create!()
    ])
  end

  it "renders a list of passwords" do
    render
  end
end
