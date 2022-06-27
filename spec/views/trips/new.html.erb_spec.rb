require 'rails_helper'

RSpec.describe "trips/new", type: :view do
  before(:each) do
    assign(:trip, Trip.new(
      user: nil,
      origin: "MyString",
      destinations: "MyString",
      available_seats: 1
    ))
  end

  it "renders new trip form" do
    render

    assert_select "form[action=?][method=?]", trips_path, "post" do

      assert_select "input[name=?]", "trip[user_id]"

      assert_select "input[name=?]", "trip[origin]"

      assert_select "input[name=?]", "trip[destinations]"

      assert_select "input[name=?]", "trip[available_seats]"
    end
  end
end
