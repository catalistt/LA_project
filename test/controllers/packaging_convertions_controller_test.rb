require 'test_helper'

class PackagingConvertionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @packaging_convertion = packaging_convertions(:one)
  end

  test "should get index" do
    get packaging_convertions_url
    assert_response :success
  end

  test "should get new" do
    get new_packaging_convertion_url
    assert_response :success
  end

  test "should create packaging_convertion" do
    assert_difference('PackagingConvertion.count') do
      post packaging_convertions_url, params: { packaging_convertion: { cost: @packaging_convertion.cost, name: @packaging_convertion.name, supplier_id: @packaging_convertion.supplier_id } }
    end

    assert_redirected_to packaging_convertion_url(PackagingConvertion.last)
  end

  test "should show packaging_convertion" do
    get packaging_convertion_url(@packaging_convertion)
    assert_response :success
  end

  test "should get edit" do
    get edit_packaging_convertion_url(@packaging_convertion)
    assert_response :success
  end

  test "should update packaging_convertion" do
    patch packaging_convertion_url(@packaging_convertion), params: { packaging_convertion: { cost: @packaging_convertion.cost, name: @packaging_convertion.name, supplier_id: @packaging_convertion.supplier_id } }
    assert_redirected_to packaging_convertion_url(@packaging_convertion)
  end

  test "should destroy packaging_convertion" do
    assert_difference('PackagingConvertion.count', -1) do
      delete packaging_convertion_url(@packaging_convertion)
    end

    assert_redirected_to packaging_convertions_url
  end
end
