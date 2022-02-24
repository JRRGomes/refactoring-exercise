class CreateUser
  def initialize(cart:, purchase_params:)
    @cart = cart
    @purchase_params = purchase_params || {}
  end

  def self.call(cart:, purchase_params:)
    new(cart: cart, purchase_params: purchase_params).create_user
  end

  def create_user
    user_params = @purchase_params[:user] || {}
    @cart.user || User.create(**user_params.merge(guest: true))
  end
end
