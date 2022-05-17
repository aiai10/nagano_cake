class Public::OrdersController < ApplicationController
  def new
    @order = Order.new
    @address = current_customer.address
  end

  def index
    @orders = current_customer.orders.all
  end

  def show
    @order = Order.find(params[:id])
    @sum = 0
  end

  def confirm
    @sum = 0
    @cart_items = current_customer.cart_items.all
    @order = Order.new(order_params)
    @order.shipping_cost = "800"
    if params[:order][:button] == "0"
      @order.address = current_customer.address
      @order.postal_code = current_customer.postal_code
      @order.name = current_customer.first_name + current_customer.last_name
    elsif params[:order][:button] == "1"
      @address = Address.find(params[:order][:address_id])
      @order.address = @address.address
      @order.postal_code = @address.postal_code
      @order.name = @address.name
    else
      @order = Order.new(order_params)
    end
  end

  def create
    order = current_customer.orders.new(order_params)
    cart_items = current_customer.cart_items.all
    if order.save
      cart_items.each do |cart|
        order_detail = OrderDetail.new
        order_detail.item_id = cart.item_id
        order_detail.order_id = order.id
        order_detail.amount = cart.amount
        order_detail.price = cart.subtotal
        order_detail.save
      end
    end
    cart_items.destroy_all
    redirect_to complete_order_path
  end

  def thanks
  end

  private
  def order_params
    params.require(:order).permit(:customer_id, :postal_code, :address, :name, :shipping_cost, :total_payment, :payment_method, :status, :created_at)
  end
end
