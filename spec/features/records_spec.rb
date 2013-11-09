require "spec_helper"
include UserManagement

feature "home page" do

  before :each do
    sign_in_user
    @patient = Patient.create name: "name", diagnosis: "diagnosis"
  end

  scenario "displays the correct title and heading" do
    visit patients_path
    expect(page).to have_title "Waivers Grant Data | Patients"
    expect(page).to have_content "Waivers Grant Data"
  end

  xscenario "displays a success message when the user saves a valid record" do
    visit patient_records_path(@patient.id)
    within "#new_record" do
      fill_in "BMI", with: 123123
      click_button "Save"
    end
    expect(page).to have_content "123123"
  end

  xscenario "displays the errors when the user tries to save an invalid record" do
    visit patient_records_path(@patient.id)
    within "#new_record" do
      click_button "Save"
    end
    expect(page).to have_content "Name can't be blank"
  end

  xscenario "displays the saved records with pagination" do
    31.times { |i| Record.create name: "foo_#{i}", diagnosis: "bar_#{i}" }
    visit records_path
    expect(page).to have_content "foo_30"
    expect(page).to have_content "foo_1"
    expect(page).to have_content "Next"
    expect(page).to_not have_content "foo_0"
  end

  xscenario "allows a user to update records" do
    Record.create name: "foo", diagnosis: "bar"
    visit records_path
    click_link "edit"
    fill_in "record_name", with: "bar"
    click_button "Update"
    expect(page).to have_content "bar"
    expect(page).to_not have_content "foo"
  end

  xscenario "provides cancelation of update" do
    Record.create name: "foo", diagnosis: "bar"
    visit records_path
    click_link "edit"
    click_link "Cancel"
    expect(page).not_to have_content "Update"
  end

  xscenario "allows a user to delete records" do
    Record.create name: "foo", diagnosis: "bar"
    visit records_path
    click_link "delete"
    expect(page).to_not have_content "foo deleted"
    within "#records" do
      expect(page).to_not have_content "foo"
    end
  end

  scenario "exports all saved records to csv" do
    31.times { |i| @patient.records.create bmi: "#{i}" }
    visit patient_records_path(@patient.id)
    expect(page).to have_link "Export all records to CSV", href: "/records.csv"
  end

  after :each do
    sign_out
  end

end
