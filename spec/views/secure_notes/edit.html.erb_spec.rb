require 'rails_helper'

RSpec.describe "secure_notes/edit", type: :view do
  before(:each) do
    @secure_note = assign(:secure_note, create(:secure_note))
    @secure_note.user.confirm
    sign_in(@secure_note.user)
  end

  it "renders the edit secure_note form" do
    render

    assert_select "form[action=?][method=?]", secure_note_path(@secure_note), "post" do
      assert_select "input[name=?]", "master_password"
      assert_select "input[name=?]", "repeat_master_password"
      assert_select "input[name=?]", "secure_note[title]"
      assert_select "textarea[name=?]", "secure_note[note]"
    end
  end
end
