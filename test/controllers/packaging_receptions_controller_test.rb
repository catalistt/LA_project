require 'test_helper'

class PackagingReceptionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @packaging_reception = packaging_receptions(:one)
  end

  test "should get index" do
    get packaging_receptions_url
    assert_response :success
  end

  test "should get new" do
    get new_packaging_reception_url
    assert_response :success
  end

  test "should create packaging_reception" do
    assert_difference('PackagingReception.count') do
      post packaging_receptions_url, params: { packaging_reception: { client_id: @packaging_reception.client_id, total_box_amount: @packaging_reception.total_box_amount, total_payed: @packaging_reception.total_payed } }
    end

    assert_redirected_to packaging_reception_url(PackagingReception.last)
  end

  test "should show packaging_reception" do
    get packaging_reception_url(@packaging_reception)
    assert_response :success
  end

  test "should get edit" do
    get edit_packaging_reception_url(@packaging_reception)
    assert_response :success
  end

  test "should update packaging_reception" do
    patch packaging_reception_url(@packaging_reception), params: { packaging_reception: { client_id: @packaging_reception.client_id, total_box_amount: @packaging_reception.total_box_amount, total_payed: @packaging_reception.total_payed } }
    assert_redirected_to packaging_reception_url(@packaging_reception)
  end

  test "should destroy packaging_reception" do
    assert_difference('PackagingReception.count', -1) do
      delete packaging_reception_url(@packaging_reception)
    end

    assert_redirected_to packaging_receptions_url
  end
end
