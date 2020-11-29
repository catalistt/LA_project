require "application_system_test_case"

class OrdersTest < ApplicationSystemTestCase
  setup do
    @order = orders(:one)
  end

  test "visiting the index" do
    visit orders_url
    assert_selector "h1", text: "Orders"
  end

  test "creating a Order" do
    visit orders_url
    click_on "New Order"

    fill_in "Client id", with: @order.client_id_id
    check "Create invoive" if @order.create_invoive
    fill_in "Delivery method id", with: @order.delivery_method_id_id
    fill_in "Discount amount", with: @order.discount_amount
    fill_in "Discount comment", with: @order.discount_comment
    fill_in "Net amount", with: @order.net_amount
    fill_in "Responsable", with: @order.responsable
    fill_in "Total amount", with: @order.total_amount
    fill_in "Total extra taxes", with: @order.total_extra_taxes
    fill_in "Total iva", with: @order.total_iva
    fill_in "Total packaging amount", with: @order.total_packaging_amount
    fill_in "User id", with: @order.user_id_id
    fill_in "Visit end", with: @order.visit_end
    fill_in "Visit start", with: @order.visit_start
    click_on "Create Order"

    assert_text "Order was successfully created"
    click_on "Back"
  end

  test "updating a Order" do
    visit orders_url
    click_on "Edit", match: :first

    fill_in "Client id", with: @order.client_id_id
    check "Create invoive" if @order.create_invoive
    fill_in "Delivery method id", with: @order.delivery_method_id_id
    fill_in "Discount amount", with: @order.discount_amount
    fill_in "Discount comment", with: @order.discount_comment
    fill_in "Net amount", with: @order.net_amount
    fill_in "Responsable", with: @order.responsable
    fill_in "Total amount", with: @order.total_amount
    fill_in "Total extra taxes", with: @order.total_extra_taxes
    fill_in "Total iva", with: @order.total_iva
    fill_in "Total packaging amount", with: @order.total_packaging_amount
    fill_in "User id", with: @order.user_id_id
    fill_in "Visit end", with: @order.visit_end
    fill_in "Visit start", with: @order.visit_start
    click_on "Update Order"

    assert_text "Order was successfully updated"
    click_on "Back"
  end

  test "destroying a Order" do
    visit orders_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Order was successfully destroyed"
  end
end
