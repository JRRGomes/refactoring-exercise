require 'rails_helper'

describe ".call" do
  it "should create order with the user and address attributes" do
    user = create(:user)
    address_params = create(:order, user: user)

    order = CreateOrder.call(user, address_params)

    expect(order.class).to eq(Order)
    expect(order.attributes).to include({ "id"=>2,
                                          "user_id"=>1,
                                          "first_name"=>user.first_name,
                                          "last_name"=>user.last_name,
                                          "address_1"=>nil,
                                          "address_2"=>nil,
                                          "city"=>nil,
                                          "state"=>nil,
                                          "country"=>nil,
                                          "zip"=>nil }
                                       )
  end
end
