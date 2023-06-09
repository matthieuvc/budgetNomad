require "application_system_test_case"

class CookersTest < ApplicationSystemTestCase
  setup do
    @cooker = cookers(:one)
  end

  test "visiting the index" do
    visit cookers_url
    assert_selector "h1", text: "Cookers"
  end

  test "should create cooker" do
    visit cookers_url
    click_on "New cooker"

    fill_in "Address", with: @cooker.address
    fill_in "Description", with: @cooker.description
    fill_in "Name", with: @cooker.name
    fill_in "Rating", with: @cooker.rating
    fill_in "Type cook", with: @cooker.type_cook
    click_on "Create Cooker"

    assert_text "Cooker was successfully created"
    click_on "Back"
  end

  test "should update Cooker" do
    visit cooker_url(@cooker)
    click_on "Edit this cooker", match: :first

    fill_in "Address", with: @cooker.address
    fill_in "Description", with: @cooker.description
    fill_in "Name", with: @cooker.name
    fill_in "Rating", with: @cooker.rating
    fill_in "Type cook", with: @cooker.type_cook
    click_on "Update Cooker"

    assert_text "Cooker was successfully updated"
    click_on "Back"
  end

  test "should destroy Cooker" do
    visit cooker_url(@cooker)
    click_on "Destroy this cooker", match: :first

    assert_text "Cooker was successfully destroyed"
  end
end
