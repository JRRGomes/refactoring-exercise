require 'rails_helper'

describe '.call' do
  let(:order) { create(:order) }
  let(:cart) { create(:cart, user: order.user) }
  let(:item) { create(:cart_item, cart: cart) }
  it 'create order line item with the order, item and shipping_costs attributes' do
    shipping_costs = 100

    order_line_item  = OrderLineItemCreator.call(order, item, shipping_costs)

    expect(order_line_item.attributes).to include({ 'order_id' => order.id,
      'sale_id' => item.sale.id,
      'unit_price_cents' => item.sale.unit_price_cents,
      'shipping_costs_cents' => shipping_costs,
      'paid_price_cents' => item.sale.unit_price_cents + shipping_costs }
      )
  end
end
