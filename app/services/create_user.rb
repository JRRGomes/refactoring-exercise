class CreateUser
  def initialize(cart, user_params)
    @cart = cart
    @user_params = user_params
  end

  def self.call(cart, user_params)
    new(cart, user_params).create_user
  end

  def create_user
    if @cart.user.nil?
      User.create(**@user_params.merge(guest: true))
    else
      @cart.user
    end
  end
end
