require 'rails_helper'

RSpec.describe "trips/show", type: :view do
  before(:each) do
    @trip = assign(:trip, Trip.create!(
      user: nil,
      origin: "Origin",
      destinations: "Destinations",
      available_seats: 2
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(/Origin/)
    expect(rendered).to match(/Destinations/)
    expect(rendered).to match(/2/)
  end
end
