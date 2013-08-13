require "spec_helper"
include UserManagement

feature "home page" do

  before :all do
    create_test_users
  end

  before :each do
    sign_in_user
  end

  scenario "displays the correct title and heading" do
    visit root_path
    expect(page).to have_title "Grant Data Capture App | Home"
    expect(page).to have_content "Grant Data Capture App"
  end

  scenario "displays a success message when the user saves a valid record" do
    visit records_path
    within "#new_record" do
      fill_in "record_name", with: "foo"
      click_button "Save"
    end
    expect(page).to have_content "Saved foo"
  end

  scenario "displays the errors when the user tries to save an invalid record" do
    visit records_path
    within "#new_record" do
      click_button "Save"
    end
    expect(page).to have_content "Name can't be blank"
  end

  scenario "displays the saved records with pagination" do
    31.times { |i| Record.create name: "foo_#{i}" }
    visit records_path
    expect(page).to have_content "foo_30"
    expect(page).to have_content "foo_1"
    expect(page).to have_content "Next"
    expect(page).to_not have_content "foo_0"
  end

  scenario "displays links to edit and delete records" do
    Record.create name: "foo"
    visit records_path
    expect(page).to have_link "edit", href: record_path(Record.first.id)
    expect(page).to have_link "delete", href: record_path(Record.first.id)
  end

  scenario "lets a user update records" do
    Record.create name: "foo"
    visit records_path
    click_link "edit"
    fill_in "record_name", with: "bar"
    click_button "Update"
    expect(page).to have_content "bar"
    expect(page).to_not have_content "foo"
  end

  scenario "exports all saved records to csv" do
    31.times { |i| Record.create name: "foo_#{i}" }
    visit records_path
    expect(page).to have_link "Export records to CSV", href: "/records.csv"
  end

  after :each do
    sign_out
  end

end
