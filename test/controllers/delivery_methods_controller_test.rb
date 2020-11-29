require 'test_helper'

class DeliveryMethodsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @delivery_method = delivery_methods(:one)
  end

  test "should get index" do
    get delivery_methods_url
    assert_response :success
  end

  test "should get new" do
    get new_delivery_method_url
    assert_response :success
  end

  test "should create delivery_method" do
    assert_difference('DeliveryMethod.count') do
      post delivery_methods_url, params: { delivery_method: { adquisition_date: @delivery_method.adquisition_date, ensurance_company: @delivery_method.ensurance_company, policy_number: @delivery_method.policy_number, vehicle_plate: @delivery_method.vehicle_plate } }
    end

    assert_redirected_to delivery_method_url(DeliveryMethod.last)
  end

  test "should show delivery_method" do
    get delivery_method_url(@delivery_method)
    assert_response :success
  end

  test "should get edit" do
    get edit_delivery_method_url(@delivery_method)
    assert_response :success
  end

  test "should update delivery_method" do
    patch delivery_method_url(@delivery_method), params: { delivery_method: { adquisition_date: @delivery_method.adquisition_date, ensurance_company: @delivery_method.ensurance_company, policy_number: @delivery_method.policy_number, vehicle_plate: @delivery_method.vehicle_plate } }
    assert_redirected_to delivery_method_url(@delivery_method)
  end

  test "should destroy delivery_method" do
    assert_difference('DeliveryMethod.count', -1) do
      delete delivery_method_url(@delivery_method)
    end

    assert_redirected_to delivery_methods_url
  end
end
