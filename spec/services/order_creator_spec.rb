require 'rails_helper'

describe '.call' do
  context 'when creating new order' do
    let(:address_params) do
      { address_1: '12 Grimmauld Place', address_2: '4 Privet Drive' }
    end
    let(:user) { create(:user) }
    let(:address_params) { { address_1: '12 Grimmauld Place', address_2: '4 Privet Drive' } }
    let(:cart) { create(:cart, user: user) }
    it 'creates order with the user and address attributes' do

      order = OrderCreator.call(user, address_params, cart)

      expect(order.attributes).to include({ 'id' => 1,
        'user_id' => 1,
        'first_name' => user.first_name,
        'last_name' => user.last_name,
        'address_1' => '12 Grimmauld Place',
        'address_2' => '4 Privet Drive',
        'city' => nil,
        'state' => nil,
        'country' => nil,
        'zip' => nil }
        )
    end
  end
end
