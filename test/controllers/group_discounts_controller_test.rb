require 'test_helper'

class GroupDiscountsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @group_discount = group_discounts(:one)
  end

  test "should get index" do
    get group_discounts_url
    assert_response :success
  end

  test "should get new" do
    get new_group_discount_url
    assert_response :success
  end

  test "should create group_discount" do
    assert_difference('GroupDiscount.count') do
      post group_discounts_url, params: { group_discount: { discount: @group_discount.discount, group_id_id: @group_discount.group_id_id, product_id_id: @group_discount.product_id_id } }
    end

    assert_redirected_to group_discount_url(GroupDiscount.last)
  end

  test "should show group_discount" do
    get group_discount_url(@group_discount)
    assert_response :success
  end

  test "should get edit" do
    get edit_group_discount_url(@group_discount)
    assert_response :success
  end

  test "should update group_discount" do
    patch group_discount_url(@group_discount), params: { group_discount: { discount: @group_discount.discount, group_id_id: @group_discount.group_id_id, product_id_id: @group_discount.product_id_id } }
    assert_redirected_to group_discount_url(@group_discount)
  end

  test "should destroy group_discount" do
    assert_difference('GroupDiscount.count', -1) do
      delete group_discount_url(@group_discount)
    end

    assert_redirected_to group_discounts_url
  end
end
