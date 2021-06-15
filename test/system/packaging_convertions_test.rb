require "application_system_test_case"

class PackagingConvertionsTest < ApplicationSystemTestCase
  setup do
    @packaging_convertion = packaging_convertions(:one)
  end

  test "visiting the index" do
    visit packaging_convertions_url
    assert_selector "h1", text: "Packaging Convertions"
  end

  test "creating a Packaging convertion" do
    visit packaging_convertions_url
    click_on "New Packaging Convertion"

    fill_in "Cost", with: @packaging_convertion.cost
    fill_in "Name", with: @packaging_convertion.name
    fill_in "Supplier", with: @packaging_convertion.supplier_id
    click_on "Create Packaging convertion"

    assert_text "Packaging convertion was successfully created"
    click_on "Back"
  end

  test "updating a Packaging convertion" do
    visit packaging_convertions_url
    click_on "Edit", match: :first

    fill_in "Cost", with: @packaging_convertion.cost
    fill_in "Name", with: @packaging_convertion.name
    fill_in "Supplier", with: @packaging_convertion.supplier_id
    click_on "Update Packaging convertion"

    assert_text "Packaging convertion was successfully updated"
    click_on "Back"
  end

  test "destroying a Packaging convertion" do
    visit packaging_convertions_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Packaging convertion was successfully destroyed"
  end
end
