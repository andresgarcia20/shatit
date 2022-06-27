require 'rails_helper'

RSpec.describe "trips/edit", type: :view do
  before(:each) do
    @trip = assign(:trip, Trip.create!(
      user: nil,
      origin: "MyString",
      destinations: "MyString",
      available_seats: 1
    ))
  end

  it "renders the edit trip form" do
    render

    assert_select "form[action=?][method=?]", trip_path(@trip), "post" do

      assert_select "input[name=?]", "trip[user_id]"

      assert_select "input[name=?]", "trip[origin]"

      assert_select "input[name=?]", "trip[destinations]"

      assert_select "input[name=?]", "trip[available_seats]"
    end
  end
end
