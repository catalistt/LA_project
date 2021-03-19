require 'test_helper'

class MoneyMovementsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @money_movement = money_movements(:one)
  end

  test "should get index" do
    get money_movements_url
    assert_response :success
  end

  test "should get new" do
    get new_money_movement_url
    assert_response :success
  end

  test "should create money_movement" do
    assert_difference('MoneyMovement.count') do
      post money_movements_url, params: { money_movement: { check_date: @money_movement.check_date, comment: @money_movement.comment, movement_category: @money_movement.movement_category, movement_type: @money_movement.movement_type, payment_method: @money_movement.payment_method, received_by: @money_movement.received_by } }
    end

    assert_redirected_to money_movement_url(MoneyMovement.last)
  end

  test "should show money_movement" do
    get money_movement_url(@money_movement)
    assert_response :success
  end

  test "should get edit" do
    get edit_money_movement_url(@money_movement)
    assert_response :success
  end

  test "should update money_movement" do
    patch money_movement_url(@money_movement), params: { money_movement: { check_date: @money_movement.check_date, comment: @money_movement.comment, movement_category: @money_movement.movement_category, movement_type: @money_movement.movement_type, payment_method: @money_movement.payment_method, received_by: @money_movement.received_by } }
    assert_redirected_to money_movement_url(@money_movement)
  end

  test "should destroy money_movement" do
    assert_difference('MoneyMovement.count', -1) do
      delete money_movement_url(@money_movement)
    end

    assert_redirected_to money_movements_url
  end
end
