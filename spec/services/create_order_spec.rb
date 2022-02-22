require 'rails_helper'

describe ".call" do
    it "should create order with the user and address attributes" do
      user = create(:user)
      address_params = {"address_1" => "Frei Serafim", "address_2" => "Dom Severino", "city" => "teresina", "state" => "PI", "country" => "Brasil", "zip" => "000"}

      order  = CreateOrder.call(user, address_params)

      expect(order.class).to eq(Order)
      expect(order.attributes).to include(attributes_for(:order, user: user))
    end  
end
