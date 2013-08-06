require "spec_helper"

feature "home page" do

  before :each do
    sign_in
    visit root_path
  end

  scenario "displays the correct title and heading" do
    expect(page).to have_title("Grant Data Capture App | Home")
    expect(page).to have_content("Grant Data Capture App")
  end

  scenario "displays a success message when the user saves a valid record" do
    within("#new_record") do
      fill_in "record_name", with: "foo"
      click_button "save"
    end
    expect(page).to have_content("foo: saved")
  end

  scenario "displays the errors when the user tries to save an invalid record" do
    within("#new_record") do
      click_button "save"
    end
    expect(page).to have_content("Name can't be blank")
  end

  after :each do
    sign_out
  end

  def sign_in
    visit new_user_session_path
    within("#new_user") do
      fill_in "user_email", with: "test@test.com"
      fill_in "user_password", with: "password!"
      click_button "Sign in"
    end
  end

  def sign_out
    visit root_path
    within("#user_panel") do
      click_link "Sign out"
    end
  end

end

