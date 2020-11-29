require "application_system_test_case"

class AddProductsTest < ApplicationSystemTestCase
  setup do
    @add_product = add_products(:one)
  end

  test "visiting the index" do
    visit add_products_url
    assert_selector "h1", text: "Add Products"
  end

  test "creating a Add product" do
    visit add_products_url
    click_on "New Add Product"

    fill_in "Discount", with: @add_product.discount
    fill_in "Order id", with: @add_product.order_id_id
    fill_in "Packaging amount", with: @add_product.packaging_amount
    fill_in "Price", with: @add_product.price
    fill_in "Product id", with: @add_product.product_id_id
    fill_in "Quantity", with: @add_product.quantity
    fill_in "Total product amount", with: @add_product.total_product_amount
    click_on "Create Add product"

    assert_text "Add product was successfully created"
    click_on "Back"
  end

  test "updating a Add product" do
    visit add_products_url
    click_on "Edit", match: :first

    fill_in "Discount", with: @add_product.discount
    fill_in "Order id", with: @add_product.order_id_id
    fill_in "Packaging amount", with: @add_product.packaging_amount
    fill_in "Price", with: @add_product.price
    fill_in "Product id", with: @add_product.product_id_id
    fill_in "Quantity", with: @add_product.quantity
    fill_in "Total product amount", with: @add_product.total_product_amount
    click_on "Update Add product"

    assert_text "Add product was successfully updated"
    click_on "Back"
  end

  test "destroying a Add product" do
    visit add_products_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Add product was successfully destroyed"
  end
end
