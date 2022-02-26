class PurchasesController < ApplicationController
  def create
    if valid_gateway?
      cart_id = purchase_params[:cart_id]

      cart = Cart.find_by(id: cart_id)

      unless cart
        return render json: { errors: [{ message: 'Cart not found!' }] }, status: :unprocessable_entity
      end

      user = UserCreator.call(cart: cart, purchase_params: purchase_params)

      if user.valid?
        order = OrderCreator.call(user, address_params, cart)

        if order.valid?
          return render json: { status: :success, order: { id: order.id } }, status: :ok
        else
          return render json: { errors: order.errors.map(&:full_message).map { |message|
                                          { message: message }
                                        } }, status: :unprocessable_entity
        end
      else
        return render json: { errors: user.errors.map(&:full_message).map { |message|
                                        { message: message }
                                      } }, status: :unprocessable_entity
      end
    else
      render json: { errors: [{ message: 'Gateway not supported!' }] }, status: :unprocessable_entity
    end
  end
  
  private
  
  GATEWAYS = %w[paypal stripe]
  
  def valid_gateway?
    GATEWAYS.include? purchase_params[:gateway]
  end
  
  def purchase_params
    params.permit(
      :gateway,
      :cart_id,
      user: %i[email first_name last_name],
      address: %i[address_1 address_2 city state country zip]
      )
  end

  def address_params
    purchase_params[:address] || {}
  end
end
