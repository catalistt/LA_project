require "application_system_test_case"

class PackagingReceptionsTest < ApplicationSystemTestCase
  setup do
    @packaging_reception = packaging_receptions(:one)
  end

  test "visiting the index" do
    visit packaging_receptions_url
    assert_selector "h1", text: "Packaging Receptions"
  end

  test "creating a Packaging reception" do
    visit packaging_receptions_url
    click_on "New Packaging Reception"

    fill_in "Client", with: @packaging_reception.client_id
    fill_in "Total box amount", with: @packaging_reception.total_box_amount
    fill_in "Total payed", with: @packaging_reception.total_payed
    click_on "Create Packaging reception"

    assert_text "Packaging reception was successfully created"
    click_on "Back"
  end

  test "updating a Packaging reception" do
    visit packaging_receptions_url
    click_on "Edit", match: :first

    fill_in "Client", with: @packaging_reception.client_id
    fill_in "Total box amount", with: @packaging_reception.total_box_amount
    fill_in "Total payed", with: @packaging_reception.total_payed
    click_on "Update Packaging reception"

    assert_text "Packaging reception was successfully updated"
    click_on "Back"
  end

  test "destroying a Packaging reception" do
    visit packaging_receptions_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Packaging reception was successfully destroyed"
  end
end
