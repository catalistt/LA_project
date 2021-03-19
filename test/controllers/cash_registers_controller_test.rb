require 'test_helper'

class CashRegistersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @cash_register = cash_registers(:one)
  end

  test "should get index" do
    get cash_registers_url
    assert_response :success
  end

  test "should get new" do
    get new_cash_register_url
    assert_response :success
  end

  test "should create cash_register" do
    assert_difference('CashRegister.count') do
      post cash_registers_url, params: { cash_register: { final_cash: @cash_register.final_cash, initial_cash: @cash_register.initial_cash } }
    end

    assert_redirected_to cash_register_url(CashRegister.last)
  end

  test "should show cash_register" do
    get cash_register_url(@cash_register)
    assert_response :success
  end

  test "should get edit" do
    get edit_cash_register_url(@cash_register)
    assert_response :success
  end

  test "should update cash_register" do
    patch cash_register_url(@cash_register), params: { cash_register: { final_cash: @cash_register.final_cash, initial_cash: @cash_register.initial_cash } }
    assert_redirected_to cash_register_url(@cash_register)
  end

  test "should destroy cash_register" do
    assert_difference('CashRegister.count', -1) do
      delete cash_register_url(@cash_register)
    end

    assert_redirected_to cash_registers_url
  end
end
