require 'rails_helper'

RSpec.describe "secure_notes/show", type: :view do
  before(:each) do
    @secure_note = assign(:secure_note, SecureNote.create!(
      :title => "Title",
      :iv => "Iv",
      :salt => "Salt",
      :password_strength => 2
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/Iv/)
    expect(rendered).to match(/Salt/)
    expect(rendered).to match(/2/)
  end
end
