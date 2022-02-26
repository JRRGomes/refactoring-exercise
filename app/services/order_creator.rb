class OrderCreator
  SHIPPING_COST = 100

  def initialize(user, address_params, cart)
    @user = user
    @address_params = address_params
    @cart = cart
  end

  def call
    ActiveRecord::Base.transaction do
      cart.items.each do |item|
        item.quantity.times do
          order.items << OrderLineItemCreator.call(order, item, SHIPPING_COST)
        end
      end
      order.save
      order
    end
  end

  def self.call(user, address_params, cart)
    new(user, address_params, cart).call
  end

  private

  attr_reader :user, :address_params, :cart

  def order
    @order ||= Order.create!(
          user: user,
          first_name: user.first_name,
          last_name: user.last_name,
          address_1: address_params[:address_1],
          address_2: address_params[:address_2],
          city: address_params[:city],
          state: address_params[:state],
          country: address_params[:country],
          zip: address_params[:zip]
          )
  end
end
