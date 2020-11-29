require "application_system_test_case"

class StockMovementsTest < ApplicationSystemTestCase
  setup do
    @stock_movement = stock_movements(:one)
  end

  test "visiting the index" do
    visit stock_movements_url
    assert_selector "h1", text: "Stock Movements"
  end

  test "creating a Stock movement" do
    visit stock_movements_url
    click_on "New Stock Movement"

    fill_in "Added", with: @stock_movement.added
    fill_in "Final stock", with: @stock_movement.final_stock
    fill_in "Initial stock", with: @stock_movement.initial_stock
    fill_in "Product id", with: @stock_movement.product_id_id
    fill_in "Removed", with: @stock_movement.removed
    click_on "Create Stock movement"

    assert_text "Stock movement was successfully created"
    click_on "Back"
  end

  test "updating a Stock movement" do
    visit stock_movements_url
    click_on "Edit", match: :first

    fill_in "Added", with: @stock_movement.added
    fill_in "Final stock", with: @stock_movement.final_stock
    fill_in "Initial stock", with: @stock_movement.initial_stock
    fill_in "Product id", with: @stock_movement.product_id_id
    fill_in "Removed", with: @stock_movement.removed
    click_on "Update Stock movement"

    assert_text "Stock movement was successfully updated"
    click_on "Back"
  end

  test "destroying a Stock movement" do
    visit stock_movements_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Stock movement was successfully destroyed"
  end
end
