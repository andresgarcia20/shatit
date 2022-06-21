require 'rails_helper'

RSpec.describe "vehicles/show", type: :view do
  before(:each) do
    @vehicle = assign(:vehicle, Vehicle.create!(
      user: nil,
      model: "Model",
      air_conditioning: false,
      vehicle_type: 2,
      consumption: 3.5,
      nickname: "Nickname"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(/Model/)
    expect(rendered).to match(/false/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/3.5/)
    expect(rendered).to match(/Nickname/)
  end
end
