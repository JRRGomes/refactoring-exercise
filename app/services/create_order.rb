class CreateOrder
  def initialize(user, address_params)
    @user = user
    @address_params = address_params
  end

  def self.call(user, address_params)
    new(user, address_params).create_order
  end

  def create_order
    Order.create!(
          user: @user,
          first_name: @user.first_name,
          last_name: @user.last_name,
          address_1: @address_params[:address_1],
          address_2: @address_params[:address_2],
          city: @address_params[:city],
          state: @address_params[:state],
          country: @address_params[:country],
          zip: @address_params[:zip]
          )
  end
end
