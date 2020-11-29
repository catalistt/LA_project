require "application_system_test_case"

class GroupDiscountsTest < ApplicationSystemTestCase
  setup do
    @group_discount = group_discounts(:one)
  end

  test "visiting the index" do
    visit group_discounts_url
    assert_selector "h1", text: "Group Discounts"
  end

  test "creating a Group discount" do
    visit group_discounts_url
    click_on "New Group Discount"

    fill_in "Discount", with: @group_discount.discount
    fill_in "Group id", with: @group_discount.group_id_id
    fill_in "Product id", with: @group_discount.product_id_id
    click_on "Create Group discount"

    assert_text "Group discount was successfully created"
    click_on "Back"
  end

  test "updating a Group discount" do
    visit group_discounts_url
    click_on "Edit", match: :first

    fill_in "Discount", with: @group_discount.discount
    fill_in "Group id", with: @group_discount.group_id_id
    fill_in "Product id", with: @group_discount.product_id_id
    click_on "Update Group discount"

    assert_text "Group discount was successfully updated"
    click_on "Back"
  end

  test "destroying a Group discount" do
    visit group_discounts_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Group discount was successfully destroyed"
  end
end
