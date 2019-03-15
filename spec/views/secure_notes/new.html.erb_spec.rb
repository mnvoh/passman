require 'rails_helper'

RSpec.describe "secure_notes/new", type: :view do
  before(:each) do
    @secure_note = assign(:secure_note, create(:secure_note))
    @secure_note.user.confirm
    sign_in(@secure_note.user)
  end

  it "renders new secure_note form" do
    render
  end
end
