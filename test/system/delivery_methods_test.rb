require "application_system_test_case"

class DeliveryMethodsTest < ApplicationSystemTestCase
  setup do
    @delivery_method = delivery_methods(:one)
  end

  test "visiting the index" do
    visit delivery_methods_url
    assert_selector "h1", text: "Delivery Methods"
  end

  test "creating a Delivery method" do
    visit delivery_methods_url
    click_on "New Delivery Method"

    fill_in "Adquisition date", with: @delivery_method.adquisition_date
    fill_in "Ensurance company", with: @delivery_method.ensurance_company
    fill_in "Policy number", with: @delivery_method.policy_number
    fill_in "Vehicle plate", with: @delivery_method.vehicle_plate
    click_on "Create Delivery method"

    assert_text "Delivery method was successfully created"
    click_on "Back"
  end

  test "updating a Delivery method" do
    visit delivery_methods_url
    click_on "Edit", match: :first

    fill_in "Adquisition date", with: @delivery_method.adquisition_date
    fill_in "Ensurance company", with: @delivery_method.ensurance_company
    fill_in "Policy number", with: @delivery_method.policy_number
    fill_in "Vehicle plate", with: @delivery_method.vehicle_plate
    click_on "Update Delivery method"

    assert_text "Delivery method was successfully updated"
    click_on "Back"
  end

  test "destroying a Delivery method" do
    visit delivery_methods_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Delivery method was successfully destroyed"
  end
end
