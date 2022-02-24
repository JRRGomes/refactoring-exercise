require 'rails_helper'

describe ".call" do
  context 'when the cart does not has a user' do
    it "creates user guest" do
      cart = create(:cart, user: nil)
      user_params = { 'email'=>'teste@spec.io', 'first_name'=>'John', 'last_name'=>'Doe'}
      
      user = CreateUser.call(cart: cart, purchase_params: { user: user_params })
      
      expect(user.class).to eq(User)
      expect(user.attributes).to include({ 'email'=>'teste@spec.io',
        'first_name'=>'John',
        'last_name'=>'Doe',
        'guest'=>true }
        )
    end
  end
end
