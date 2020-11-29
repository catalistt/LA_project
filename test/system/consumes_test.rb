require "application_system_test_case"

class ConsumesTest < ApplicationSystemTestCase
  setup do
    @consume = consumes(:one)
  end

  test "visiting the index" do
    visit consumes_url
    assert_selector "h1", text: "Consumes"
  end

  test "creating a Consume" do
    visit consumes_url
    click_on "New Consume"

    fill_in "Quantity", with: @consume.quantity
    fill_in "Resource id", with: @consume.resource_id_id
    fill_in "Total amount", with: @consume.total_amount
    fill_in "User id", with: @consume.user_id_id
    click_on "Create Consume"

    assert_text "Consume was successfully created"
    click_on "Back"
  end

  test "updating a Consume" do
    visit consumes_url
    click_on "Edit", match: :first

    fill_in "Quantity", with: @consume.quantity
    fill_in "Resource id", with: @consume.resource_id_id
    fill_in "Total amount", with: @consume.total_amount
    fill_in "User id", with: @consume.user_id_id
    click_on "Update Consume"

    assert_text "Consume was successfully updated"
    click_on "Back"
  end

  test "destroying a Consume" do
    visit consumes_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Consume was successfully destroyed"
  end
end
