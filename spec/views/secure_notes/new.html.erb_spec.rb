require 'rails_helper'

RSpec.describe "secure_notes/new", type: :view do
  before(:each) do
    assign(:secure_note, SecureNote.new(
      :title => "MyString",
      :iv => "MyString",
      :salt => "MyString",
      :password_strength => 1
    ))
  end

  it "renders new secure_note form" do
    render

    assert_select "form[action=?][method=?]", secure_notes_path, "post" do

      assert_select "input[name=?]", "secure_note[title]"

      assert_select "input[name=?]", "secure_note[iv]"

      assert_select "input[name=?]", "secure_note[salt]"

      assert_select "input[name=?]", "secure_note[password_strength]"
    end
  end
end
