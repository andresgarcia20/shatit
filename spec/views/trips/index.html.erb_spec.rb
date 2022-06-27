require 'rails_helper'

RSpec.describe "trips/index", type: :view do
  before(:each) do
    assign(:trips, [
      Trip.create!(
        user: nil,
        origin: "Origin",
        destinations: "Destinations",
        available_seats: 2
      ),
      Trip.create!(
        user: nil,
        origin: "Origin",
        destinations: "Destinations",
        available_seats: 2
      )
    ])
  end

  it "renders a list of trips" do
    render
    assert_select "tr>td", text: nil.to_s, count: 2
    assert_select "tr>td", text: "Origin".to_s, count: 2
    assert_select "tr>td", text: "Destinations".to_s, count: 2
    assert_select "tr>td", text: 2.to_s, count: 2
  end
end
