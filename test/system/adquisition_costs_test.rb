require "application_system_test_case"

class AdquisitionCostsTest < ApplicationSystemTestCase
  setup do
    @adquisition_cost = adquisition_costs(:one)
  end

  test "visiting the index" do
    visit adquisition_costs_url
    assert_selector "h1", text: "Adquisition Costs"
  end

  test "creating a Adquisition cost" do
    visit adquisition_costs_url
    click_on "New Adquisition Cost"

    fill_in "Cost", with: @adquisition_cost.cost
    fill_in "Product id", with: @adquisition_cost.product_id_id
    click_on "Create Adquisition cost"

    assert_text "Adquisition cost was successfully created"
    click_on "Back"
  end

  test "updating a Adquisition cost" do
    visit adquisition_costs_url
    click_on "Edit", match: :first

    fill_in "Cost", with: @adquisition_cost.cost
    fill_in "Product id", with: @adquisition_cost.product_id_id
    click_on "Update Adquisition cost"

    assert_text "Adquisition cost was successfully updated"
    click_on "Back"
  end

  test "destroying a Adquisition cost" do
    visit adquisition_costs_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Adquisition cost was successfully destroyed"
  end
end
