require 'rails_helper'

RSpec.describe "secure_notes/show", type: :view do
  before(:each) do
    @secure_note = assign(:secure_note, create(:secure_note))
    @secure_note.user.confirm
    sign_in(@secure_note.user)
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Example/)
  end
end
