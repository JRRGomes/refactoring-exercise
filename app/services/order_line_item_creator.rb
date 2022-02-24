class OrderLineItemCreator
  def initialize(order, item, shipping_costs)
    @order = order
    @item = item
    @shipping_costs = shipping_costs
  end

  def self.call(order, item, shipping_costs)
    new(order, item, shipping_costs).create_order_line_item
  end

  def create_order_line_item
    OrderLineItem.create!(
              order: @order,
              sale: @item.sale,
              unit_price_cents: @item.sale.unit_price_cents,
              shipping_costs_cents: @shipping_costs,
              paid_price_cents: @item.sale.unit_price_cents + @shipping_costs
              )
  end
end
