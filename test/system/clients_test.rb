require "application_system_test_case"

class ClientsTest < ApplicationSystemTestCase
  setup do
    @client = clients(:one)
  end

  test "visiting the index" do
    visit clients_url
    assert_selector "h1", text: "Clients"
  end

  test "creating a Client" do
    visit clients_url
    click_on "New Client"

    fill_in "Address", with: @client.address
    fill_in "Business name", with: @client.business_name
    fill_in "Group id", with: @client.group_id_id
    fill_in "Phone number", with: @client.phone_number
    fill_in "Rut", with: @client.rut
    fill_in "Schedule", with: @client.schedule
    fill_in "Special agreeement", with: @client.special_agreeement
    fill_in "User id", with: @client.user_id_id
    click_on "Create Client"

    assert_text "Client was successfully created"
    click_on "Back"
  end

  test "updating a Client" do
    visit clients_url
    click_on "Edit", match: :first

    fill_in "Address", with: @client.address
    fill_in "Business name", with: @client.business_name
    fill_in "Group id", with: @client.group_id_id
    fill_in "Phone number", with: @client.phone_number
    fill_in "Rut", with: @client.rut
    fill_in "Schedule", with: @client.schedule
    fill_in "Special agreeement", with: @client.special_agreeement
    fill_in "User id", with: @client.user_id_id
    click_on "Update Client"

    assert_text "Client was successfully updated"
    click_on "Back"
  end

  test "destroying a Client" do
    visit clients_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Client was successfully destroyed"
  end
end
