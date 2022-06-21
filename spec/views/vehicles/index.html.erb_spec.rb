require 'rails_helper'

RSpec.describe "vehicles/index", type: :view do
  before(:each) do
    assign(:vehicles, [
      Vehicle.create!(
        user: nil,
        model: "Model",
        air_conditioning: false,
        vehicle_type: 2,
        consumption: 3.5,
        nickname: "Nickname"
      ),
      Vehicle.create!(
        user: nil,
        model: "Model",
        air_conditioning: false,
        vehicle_type: 2,
        consumption: 3.5,
        nickname: "Nickname"
      )
    ])
  end

  it "renders a list of vehicles" do
    render
    assert_select "tr>td", text: nil.to_s, count: 2
    assert_select "tr>td", text: "Model".to_s, count: 2
    assert_select "tr>td", text: false.to_s, count: 2
    assert_select "tr>td", text: 2.to_s, count: 2
    assert_select "tr>td", text: 3.5.to_s, count: 2
    assert_select "tr>td", text: "Nickname".to_s, count: 2
  end
end
