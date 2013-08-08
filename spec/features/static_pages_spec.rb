require "spec_helper"
include UserManagement

feature "home page" do

  before :all do
    create_test_users
  end

  scenario "displays the correct title and heading" do
    sign_in_user
    visit root_path
    expect(page).to have_title "Grant Data Capture App | Home"
    expect(page).to have_content "Grant Data Capture App"
  end

  scenario "displays a success message when the user saves a valid record" do
    sign_in_user
    visit root_path
    within "#new_record" do
      fill_in "record_name", with: "foo"
      click_button "save"
    end
    expect(page).to have_content "foo: saved"
  end

  scenario "displays the errors when the user tries to save an invalid record" do
    sign_in_user
    visit root_path
    within "#new_record" do
      click_button "save"
    end
    expect(page).to have_content "Name can't be blank"
  end

  scenario "displays the saved records with pagination" do
    31.times { |i| Record.create name: "foo_#{i}" }
    sign_in_user
    visit records_path
    expect(page).to have_content "foo_0"
    expect(page).to have_content "foo_29"
    expect(page).to have_content "Next"
    expect(page).to_not have_content "foo_30"
  end

  after :each do
    sign_out
  end

end
