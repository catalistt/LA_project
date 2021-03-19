require "application_system_test_case"

class MoneyMovementsTest < ApplicationSystemTestCase
  setup do
    @money_movement = money_movements(:one)
  end

  test "visiting the index" do
    visit money_movements_url
    assert_selector "h1", text: "Money Movements"
  end

  test "creating a Money movement" do
    visit money_movements_url
    click_on "New Money Movement"

    fill_in "Check date", with: @money_movement.check_date
    fill_in "Comment", with: @money_movement.comment
    fill_in "Movement category", with: @money_movement.movement_category
    fill_in "Movement type", with: @money_movement.movement_type
    fill_in "Payment method", with: @money_movement.payment_method
    fill_in "Received by", with: @money_movement.received_by
    click_on "Create Money movement"

    assert_text "Money movement was successfully created"
    click_on "Back"
  end

  test "updating a Money movement" do
    visit money_movements_url
    click_on "Edit", match: :first

    fill_in "Check date", with: @money_movement.check_date
    fill_in "Comment", with: @money_movement.comment
    fill_in "Movement category", with: @money_movement.movement_category
    fill_in "Movement type", with: @money_movement.movement_type
    fill_in "Payment method", with: @money_movement.payment_method
    fill_in "Received by", with: @money_movement.received_by
    click_on "Update Money movement"

    assert_text "El movimiento de dinero se actualizó correctamente"
    click_on "Back"
  end

  test "destroying a Money movement" do
    visit money_movements_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Money movement was successfully destroyed"
  end
end
