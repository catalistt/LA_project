require 'test_helper'

class AddItemsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @add_item = add_items(:one)
  end

  test "should get index" do
    get add_items_url
    assert_response :success
  end

  test "should get new" do
    get new_add_item_url
    assert_response :success
  end

  test "should create add_item" do
    assert_difference('AddItem.count') do
      post add_items_url, params: { add_item: { expiration_date: @add_item.expiration_date, price: @add_item.price, product_id: @add_item.product_id, purchase_id: @add_item.purchase_id, quantity: @add_item.quantity, second_expiration_date: @add_item.second_expiration_date, total_product_amount: @add_item.total_product_amount } }
    end

    assert_redirected_to add_item_url(AddItem.last)
  end

  test "should show add_item" do
    get add_item_url(@add_item)
    assert_response :success
  end

  test "should get edit" do
    get edit_add_item_url(@add_item)
    assert_response :success
  end

  test "should update add_item" do
    patch add_item_url(@add_item), params: { add_item: { expiration_date: @add_item.expiration_date, price: @add_item.price, product_id: @add_item.product_id, purchase_id: @add_item.purchase_id, quantity: @add_item.quantity, second_expiration_date: @add_item.second_expiration_date, total_product_amount: @add_item.total_product_amount } }
    assert_redirected_to add_item_url(@add_item)
  end

  test "should destroy add_item" do
    assert_difference('AddItem.count', -1) do
      delete add_item_url(@add_item)
    end

    assert_redirected_to add_items_url
  end
end
