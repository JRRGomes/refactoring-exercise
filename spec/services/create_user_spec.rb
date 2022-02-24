require 'rails_helper'

describe ".call" do
  it "creates user guest" do
    user_params = create(:user, guest: true)
    cart = create(:cart, user: user_params)

    user = CreateUser.call(cart, user_params)

    expect(user.class).to eq(User)
    expect(user.attributes).to include({ "id"=>1,
                                         "email"=>"user@spec.io",
                                         "first_name"=>"John",
                                         "last_name"=>"Doe",
                                         "guest"=>true }
                                       )
  end
end
