require "spec_helper"

feature "Home page" do
  scenario "displays the correct title and heading" do
    visit root_path
    expect(page).to have_title("Grant Data Capture App | Home")
    expect(page).to have_content("Grant Data Capture App")
  end
end
