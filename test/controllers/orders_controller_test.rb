require 'test_helper'

class OrdersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @order = orders(:one)
  end

  test "should get index" do
    get orders_url
    assert_response :success
  end

  test "should get new" do
    get new_order_url
    assert_response :success
  end

  test "should create order" do
    assert_difference('Order.count') do
      post orders_url, params: { order: { client_id_id: @order.client_id_id, create_invoive: @order.create_invoive, delivery_method_id_id: @order.delivery_method_id_id, discount_amount: @order.discount_amount, discount_comment: @order.discount_comment, net_amount: @order.net_amount, responsable: @order.responsable, total_amount: @order.total_amount, total_extra_taxes: @order.total_extra_taxes, total_iva: @order.total_iva, total_packaging_amount: @order.total_packaging_amount, user_id_id: @order.user_id_id, visit_end: @order.visit_end, visit_start: @order.visit_start } }
    end

    assert_redirected_to order_url(Order.last)
  end

  test "should show order" do
    get order_url(@order)
    assert_response :success
  end

  test "should get edit" do
    get edit_order_url(@order)
    assert_response :success
  end

  test "should update order" do
    patch order_url(@order), params: { order: { client_id_id: @order.client_id_id, create_invoive: @order.create_invoive, delivery_method_id_id: @order.delivery_method_id_id, discount_amount: @order.discount_amount, discount_comment: @order.discount_comment, net_amount: @order.net_amount, responsable: @order.responsable, total_amount: @order.total_amount, total_extra_taxes: @order.total_extra_taxes, total_iva: @order.total_iva, total_packaging_amount: @order.total_packaging_amount, user_id_id: @order.user_id_id, visit_end: @order.visit_end, visit_start: @order.visit_start } }
    assert_redirected_to order_url(@order)
  end

  test "should destroy order" do
    assert_difference('Order.count', -1) do
      delete order_url(@order)
    end

    assert_redirected_to orders_url
  end
end
