require "spec_helper"

feature "home page" do

  scenario "displays the correct title and heading" do
    visit root_path
    expect(page).to have_title("Grant Data Capture App | Home")
    expect(page).to have_content("Grant Data Capture App")
  end

  scenario "dispalys a success message when the user saves a valid record" do
    visit root_path
    within("#new_record") do
      fill_in "record_name", with: "foo"
      click_button "save"
    end
    expect(page).to have_content("foo: saved")
  end

  scenario "dispalys a success message when the user saves an invalid record" do
    visit root_path
    within("#new_record") do
      click_button "save"
    end
    expect(page).to have_content("Name can't be blank")
  end

end
