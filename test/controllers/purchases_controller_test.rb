require 'test_helper'

class PurchasesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @purchase = purchases(:one)
  end

  test "should get index" do
    get purchases_url
    assert_response :success
  end

  test "should get new" do
    get new_purchase_url
    assert_response :success
  end

  test "should create purchase" do
    assert_difference('Purchase.count') do
      post purchases_url, params: { purchase: { expiration_date: @purchase.expiration_date, invoice_number: @purchase.invoice_number, price: @purchase.price, product_id_id: @purchase.product_id_id, quantity: @purchase.quantity, second_expiration_date: @purchase.second_expiration_date, subtotal: @purchase.subtotal, supplier_id_id: @purchase.supplier_id_id } }
    end

    assert_redirected_to purchase_url(Purchase.last)
  end

  test "should show purchase" do
    get purchase_url(@purchase)
    assert_response :success
  end

  test "should get edit" do
    get edit_purchase_url(@purchase)
    assert_response :success
  end

  test "should update purchase" do
    patch purchase_url(@purchase), params: { purchase: { expiration_date: @purchase.expiration_date, invoice_number: @purchase.invoice_number, price: @purchase.price, product_id_id: @purchase.product_id_id, quantity: @purchase.quantity, second_expiration_date: @purchase.second_expiration_date, subtotal: @purchase.subtotal, supplier_id_id: @purchase.supplier_id_id } }
    assert_redirected_to purchase_url(@purchase)
  end

  test "should destroy purchase" do
    assert_difference('Purchase.count', -1) do
      delete purchase_url(@purchase)
    end

    assert_redirected_to purchases_url
  end
end
