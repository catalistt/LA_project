require "application_system_test_case"

class PurchasesTest < ApplicationSystemTestCase
  setup do
    @purchase = purchases(:one)
  end

  test "visiting the index" do
    visit purchases_url
    assert_selector "h1", text: "Purchases"
  end

  test "creating a Purchase" do
    visit purchases_url
    click_on "New Purchase"

    fill_in "Expiration date", with: @purchase.expiration_date
    fill_in "Invoice number", with: @purchase.invoice_number
    fill_in "Price", with: @purchase.price
    fill_in "Product id", with: @purchase.product_id_id
    fill_in "Quantity", with: @purchase.quantity
    fill_in "Second expiration date", with: @purchase.second_expiration_date
    fill_in "Subtotal", with: @purchase.subtotal
    fill_in "Supplier id", with: @purchase.supplier_id_id
    click_on "Create Purchase"

    assert_text "Purchase was successfully created"
    click_on "Back"
  end

  test "updating a Purchase" do
    visit purchases_url
    click_on "Edit", match: :first

    fill_in "Expiration date", with: @purchase.expiration_date
    fill_in "Invoice number", with: @purchase.invoice_number
    fill_in "Price", with: @purchase.price
    fill_in "Product id", with: @purchase.product_id_id
    fill_in "Quantity", with: @purchase.quantity
    fill_in "Second expiration date", with: @purchase.second_expiration_date
    fill_in "Subtotal", with: @purchase.subtotal
    fill_in "Supplier id", with: @purchase.supplier_id_id
    click_on "Update Purchase"

    assert_text "Purchase was successfully updated"
    click_on "Back"
  end

  test "destroying a Purchase" do
    visit purchases_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Purchase was successfully destroyed"
  end
end
