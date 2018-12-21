require 'rails_helper'

RSpec.describe "secure_notes/index", type: :view do
  before(:each) do
    assign(:secure_notes, [
      SecureNote.create!(
        :title => "Title",
        :iv => "Iv",
        :salt => "Salt",
        :password_strength => 2
      ),
      SecureNote.create!(
        :title => "Title",
        :iv => "Iv",
        :salt => "Salt",
        :password_strength => 2
      )
    ])
  end

  it "renders a list of secure_notes" do
    render
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "Iv".to_s, :count => 2
    assert_select "tr>td", :text => "Salt".to_s, :count => 2
    assert_select "tr>td", :text => 2.to_s, :count => 2
  end
end
