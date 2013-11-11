require "spec_helper"
include UserManagement

feature "patient records page" do
  before :each do
    sign_in_user
    @patient = Patient.create name: "name", diagnosis: "diagnosis"
  end

  scenario "displays the correct title and heading" do
    visit patient_records_path(@patient.id)
    expect(page).to have_title "Waivers Grant Data | Records"
    expect(page).to have_content "Waivers Grant Data"
  end

  scenario "displays errors when user tries to save an invalid record" do
    visit patient_records_path(@patient.id)
    within "#new_record" do
      fill_in "BMI", with: "non-numeric value"
      fill_in "A1c", with: -1
      fill_in "TC", with: 1.5
      click_button "Save"
    end
    expect(page).to have_content "Bmi must be a non-negative number"
    expect(page).to have_content "A1c must be a non-negative number"
    expect(page).to have_content "Tc must be a non-negative, whole number"
  end

  scenario "does not allow saving a record with all fields blank" do
    visit patient_records_path(@patient.id)
    expect { click_button "Save" }.not_to change{ @patient.records.count }
    expect(page).to have_content "Please enter some patient data"
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
