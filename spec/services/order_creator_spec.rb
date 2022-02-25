require 'rails_helper'

describe '.call' do
  context 'when creating new order' do
    it 'creates order with the user and address attributes' do
      user = create(:user)
      address_params = { address_1: '12 Grimmauld Place', address_2: '4 Privet Drive' }

      order = OrderCreator.call(user, address_params)

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
