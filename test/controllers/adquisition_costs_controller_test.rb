require 'test_helper'

class AdquisitionCostsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @adquisition_cost = adquisition_costs(:one)
  end

  test "should get index" do
    get adquisition_costs_url
    assert_response :success
  end

  test "should get new" do
    get new_adquisition_cost_url
    assert_response :success
  end

  test "should create adquisition_cost" do
    assert_difference('AdquisitionCost.count') do
      post adquisition_costs_url, params: { adquisition_cost: { cost: @adquisition_cost.cost, product_id_id: @adquisition_cost.product_id_id } }
    end

    assert_redirected_to adquisition_cost_url(AdquisitionCost.last)
  end

  test "should show adquisition_cost" do
    get adquisition_cost_url(@adquisition_cost)
    assert_response :success
  end

  test "should get edit" do
    get edit_adquisition_cost_url(@adquisition_cost)
    assert_response :success
  end

  test "should update adquisition_cost" do
    patch adquisition_cost_url(@adquisition_cost), params: { adquisition_cost: { cost: @adquisition_cost.cost, product_id_id: @adquisition_cost.product_id_id } }
    assert_redirected_to adquisition_cost_url(@adquisition_cost)
  end

  test "should destroy adquisition_cost" do
    assert_difference('AdquisitionCost.count', -1) do
      delete adquisition_cost_url(@adquisition_cost)
    end

    assert_redirected_to adquisition_costs_url
  end
end
