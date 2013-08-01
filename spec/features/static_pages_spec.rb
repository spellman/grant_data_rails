require "spec_helper"

feature "home page" do

  scenario "displays the correct title and heading" do
    visit root_path
    expect(page).to have_title("Grant Data Capture App | Home")
    expect(page).to have_content("Grant Data Capture App")
  end

  scenario "dispalys a success message when the user saves a record" do
    visit "/"
    within("#form") do
      fill_in "name", with: "foo"
      click_button "save"
    end
    expect(page).to have_content("foo: saved")
  end

end
