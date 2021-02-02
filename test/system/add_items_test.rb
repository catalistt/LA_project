require "application_system_test_case"

class AddItemsTest < ApplicationSystemTestCase
  setup do
    @add_item = add_items(:one)
  end

  test "visiting the index" do
    visit add_items_url
    assert_selector "h1", text: "Add Items"
  end

  test "creating a Add item" do
    visit add_items_url
    click_on "New Add Item"

    fill_in "Expiration date", with: @add_item.expiration_date
    fill_in "Price", with: @add_item.price
    fill_in "Product", with: @add_item.product_id
    fill_in "Purchase", with: @add_item.purchase_id
    fill_in "Quantity", with: @add_item.quantity
    fill_in "Second expiration date", with: @add_item.second_expiration_date
    fill_in "Total product amount", with: @add_item.total_product_amount
    click_on "Create Add item"

    assert_text "Add item was successfully created"
    click_on "Back"
  end

  test "updating a Add item" do
    visit add_items_url
    click_on "Edit", match: :first

    fill_in "Expiration date", with: @add_item.expiration_date
    fill_in "Price", with: @add_item.price
    fill_in "Product", with: @add_item.product_id
    fill_in "Purchase", with: @add_item.purchase_id
    fill_in "Quantity", with: @add_item.quantity
    fill_in "Second expiration date", with: @add_item.second_expiration_date
    fill_in "Total product amount", with: @add_item.total_product_amount
    click_on "Update Add item"

    assert_text "Add item was successfully updated"
    click_on "Back"
  end

  test "destroying a Add item" do
    visit add_items_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Add item was successfully destroyed"
  end
end
