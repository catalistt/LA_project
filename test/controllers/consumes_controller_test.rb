require 'test_helper'

class ConsumesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @consume = consumes(:one)
  end

  test "should get index" do
    get consumes_url
    assert_response :success
  end

  test "should get new" do
    get new_consume_url
    assert_response :success
  end

  test "should create consume" do
    assert_difference('Consume.count') do
      post consumes_url, params: { consume: { quantity: @consume.quantity, resource_id_id: @consume.resource_id_id, total_amount: @consume.total_amount, user_id_id: @consume.user_id_id } }
    end

    assert_redirected_to consume_url(Consume.last)
  end

  test "should show consume" do
    get consume_url(@consume)
    assert_response :success
  end

  test "should get edit" do
    get edit_consume_url(@consume)
    assert_response :success
  end

  test "should update consume" do
    patch consume_url(@consume), params: { consume: { quantity: @consume.quantity, resource_id_id: @consume.resource_id_id, total_amount: @consume.total_amount, user_id_id: @consume.user_id_id } }
    assert_redirected_to consume_url(@consume)
  end

  test "should destroy consume" do
    assert_difference('Consume.count', -1) do
      delete consume_url(@consume)
    end

    assert_redirected_to consumes_url
  end
end
