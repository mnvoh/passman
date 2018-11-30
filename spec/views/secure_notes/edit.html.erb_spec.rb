require 'rails_helper'

RSpec.describe "secure_notes/edit", type: :view do
  before(:each) do
    @secure_note = assign(:secure_note, SecureNote.create!(
      :title => "MyString",
      :iv => "MyString",
      :salt => "MyString",
      :password_strength => 1
    ))
  end

  it "renders the edit secure_note form" do
    render

    assert_select "form[action=?][method=?]", secure_note_path(@secure_note), "post" do

      assert_select "input[name=?]", "secure_note[title]"

      assert_select "input[name=?]", "secure_note[iv]"

      assert_select "input[name=?]", "secure_note[salt]"

      assert_select "input[name=?]", "secure_note[password_strength]"
    end
  end
end
