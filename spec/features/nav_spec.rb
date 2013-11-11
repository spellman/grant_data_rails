require "spec_helper"
include UserManagement

feature "patient index page navigation" do
  before :each do
    @patients_link     = "Patients"
    @sign_out_link     = "Sign out"
    @manage_users_link = "Manage users"
  end

  scenario "non-admin user" do
    sign_in_user
    visit patients_path
    expect(find(".navbar")).to have_link @patients_link
    expect(find(".navbar")).to have_link "Export data for all patients to CSV"
    expect(find(".navbar")).to have_link "#{@user.email}"
    expect(find(".navbar")).to have_link @sign_out_link
    expect(find(".navbar")).not_to have_link @manage_users_link
  end

  scenario "admin user" do
    sign_in_admin
    visit patients_path
    expect(find(".navbar")).to have_link @patients_link
    expect(find(".navbar")).to have_link "Export data for all patients to CSV"
    expect(find(".navbar")).to have_link "#{@admin.email}"
    expect(find(".navbar")).to have_link @sign_out_link
    expect(find(".navbar")).to have_link @manage_users_link
  end

  after :each do
    sign_out
  end
end

feature "patient show page navigation" do
  before :each do
    @patients_link     = "Patients"
    @sign_out_link     = "Sign out"
    @manage_users_link = "Manage users"
  end

  scenario "non-admin user" do
    sign_in_user
    visit patients_path
    expect(find(".navbar")).to have_link @patients_link
    expect(find(".navbar")).to have_link "Export data for all patients to CSV"
    expect(find(".navbar")).to have_link "#{@user.email}"
    expect(find(".navbar")).to have_link @sign_out_link
    expect(find(".navbar")).not_to have_link @manage_users_link
  end

  scenario "admin user" do
    sign_in_admin
    visit patients_path
    expect(find(".navbar")).to have_link @patients_link
    expect(find(".navbar")).to have_link "Export data for all patients to CSV"
    expect(find(".navbar")).to have_link "#{@admin.email}"
    expect(find(".navbar")).to have_link @sign_out_link
    expect(find(".navbar")).to have_link @manage_users_link
  end

  after :each do
    sign_out
  end
end

feature "patient records page navigation" do
  before :each do
    @patient           = Patient.create name: "name", diagnosis: "diagnosis"
    @patients_link     = "Patients"
    @sign_out_link     = "Sign out"
    @manage_users_link = "Manage users"
  end

  scenario "non-admin user" do
    sign_in_user
    visit patient_records_path(@patient.id)
    expect(find(".navbar")).to have_link @patients_link
    expect(find(".navbar")).to have_link "Export data for #{@patient.name} to CSV"
    expect(find(".navbar")).to have_link "#{@user.email}"
    expect(find(".navbar")).to have_link @sign_out_link
    expect(find(".navbar")).not_to have_link @manage_users_link
  end

  scenario "admin user" do
    sign_in_admin
    visit patient_records_path(@patient.id)
    expect(find(".navbar")).to have_link @patients_link
    expect(find(".navbar")).to have_link "Export data for #{@patient.name} to CSV"
    expect(find(".navbar")).to have_link "#{@admin.email}"
    expect(find(".navbar")).to have_link @sign_out_link
    expect(find(".navbar")).to have_link @manage_users_link
  end

  after :each do
    sign_out
  end
end
