require 'rails_helper'

RSpec.describe "secure_notes/index", type: :view do
  before(:each) do
    @secure_notes = assign(:secure_notes, create_list(:secure_note, 2))
    @secure_notes.first.user.confirm
    sign_in(@secure_notes.first.user)
  end

  it "renders a list of secure_notes" do
    render
    assert_select "tr>td", :text => "Example".to_s, :count => 2
  end
end
