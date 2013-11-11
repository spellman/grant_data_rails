require "spec_helper"
include UserManagement

feature "patients page" do
  before :each do
    sign_in_user
    @p0 = Patient.create name: "patient 0", diagnosis: "diagnosis 0"
    @p1 = Patient.create name: "patient 1", diagnosis: "diagnosis 1"
  end

  scenario "displays the correct title and heading" do
    visit patients_path
    expect(page).to have_title "Waivers Grant Data | Patients"
    expect(page).to have_content "Waivers Grant Data"
  end

  scenario "displays a list of patients" do
    visit patients_path
    expect(page).to have_content @p0.name
    expect(page).to have_content @p1.name
  end

  scenario "displays a link to the records of each patient" do
    visit patients_path
    expect(page).to have_link "patient records", href: "/patients/#{@p0.id}/records"
    expect(page).to have_link "patient records", href: "/patients/#{@p1.id}/records"
  end

  scenario "displays a link to edit each patient" do
    visit patients_path
    expect(page).to have_link "edit patient", href: "/patients/#{@p0.id}"
    expect(page).to have_link "edit patient", href: "/patients/#{@p1.id}"
  end

  scenario "displays a link to delete each patient" do
    visit patients_path
    expect(page).to have_link "delete patient", href: "/patients/#{@p0.id}"
    expect(page).to have_link "delete patient", href: "/patients/#{@p1.id}"
  end

  scenario "finds patients by name" do
    patient = Patient.create name: "test name", diagnosis: "test diagnosis"
    visit patients_path
    within "#find-patients" do
      fill_in "search[name]", with: patient.name
      click_button "Find patient(s)"
    end
    expect(page).to have_content patient.name
    expect(page).to have_content patient.diagnosis
  end
end
