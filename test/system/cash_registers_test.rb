require "application_system_test_case"

class CashRegistersTest < ApplicationSystemTestCase
  setup do
    @cash_register = cash_registers(:one)
  end

  test "visiting the index" do
    visit cash_registers_url
    assert_selector "h1", text: "Cash Registers"
  end

  test "creating a Cash register" do
    visit cash_registers_url
    click_on "New Cash Register"

    fill_in "Final cash", with: @cash_register.final_cash
    fill_in "Initial cash", with: @cash_register.initial_cash
    click_on "Create Cash register"

    assert_text "Cash register was successfully created"
    click_on "Back"
  end

  test "updating a Cash register" do
    visit cash_registers_url
    click_on "Edit", match: :first

    fill_in "Final cash", with: @cash_register.final_cash
    fill_in "Initial cash", with: @cash_register.initial_cash
    click_on "Update Cash register"

    assert_text "Cash register was successfully updated"
    click_on "Back"
  end

  test "destroying a Cash register" do
    visit cash_registers_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Cash register was successfully destroyed"
  end
end
