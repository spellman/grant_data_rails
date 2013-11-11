require "spec_helper"
include UserManagement

feature "patients display" do
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

  after :each do
    sign_out
  end
end

feature "patient search" do
  before :each do
    sign_in_user
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

  after :each do
    sign_out
  end
end

feature "add patient" do
  before :each do
    sign_in_user
  end

  scenario "allows user to create a new patient" do
    previous_count = Patient.count
    visit patients_path
    expect do
      within "#add-patient" do
        fill_in "Name", with: "new name"
        fill_in "Diagnosis", with: "new diagnosis"
        click_button "Add new patient"
      end
    end.to change{ Patient.count }.from(previous_count).to(previous_count + 1)
    expect(page).to have_content "new name"
    expect(page).to have_content "new diagnosis"
  end

  scenario "displays errors when user tries to save a patient with invalid data" do
    visit patients_path
    within "#add-patient" do
      fill_in "Name", with: ""
      fill_in "Diagnosis", with: ""
      click_button "Add new patient"
    end
    expect(page).to have_content "Name can't be blank"
    expect(page).to have_content "Diagnosis can't be blank"
  end

  scenario "does not allow saving a patient with invalid data" do
    visit patients_path
    expect{ click_button "Add new patient" }.not_to change{ Patient.count }
  end

  after :each do
    sign_out
  end
end
