require 'rails_helper'

describe ".call" do
  context 'when the cart does not has a user' do
    let(:cart) { create(:cart, user: nil) }
    it "creates user guest" do
      user_params = { 'email' => 'user@spec.io', 'first_name' => 'John', 'last_name' => 'Doe' }
      
      user = UserCreator.call(cart: cart, purchase_params: { user: user_params })

      expect(user.class).to eq(User)
      expect(user.attributes).to include({ 'email' => 'user@spec.io',
        'first_name' => 'John',
        'last_name' => 'Doe',
        'guest' => true }
        )
    end
  end

  context 'when the cart has a user' do
    it 'return the cart user' do
      cart_user = create(:user)
      cart = create(:cart, user: cart_user)

      user = UserCreator.call(cart: cart, purchase_params: {})

      expect(user.class).to eq(User)
      expect(user.attributes).to include(cart_user.attributes)
    end
  end
end
