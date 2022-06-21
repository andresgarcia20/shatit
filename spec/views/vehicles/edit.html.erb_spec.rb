require 'rails_helper'

RSpec.describe "vehicles/edit", type: :view do
  before(:each) do
    @vehicle = assign(:vehicle, Vehicle.create!(
      user: nil,
      model: "MyString",
      air_conditioning: false,
      vehicle_type: 1,
      consumption: 1.5,
      nickname: "MyString"
    ))
  end

  it "renders the edit vehicle form" do
    render

    assert_select "form[action=?][method=?]", vehicle_path(@vehicle), "post" do

      assert_select "input[name=?]", "vehicle[user_id]"

      assert_select "input[name=?]", "vehicle[model]"

      assert_select "input[name=?]", "vehicle[air_conditioning]"

      assert_select "input[name=?]", "vehicle[vehicle_type]"

      assert_select "input[name=?]", "vehicle[consumption]"

      assert_select "input[name=?]", "vehicle[nickname]"
    end
  end
end
