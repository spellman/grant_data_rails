require "spec_helper"
include UserManagement

feature "home page navigation" do
  scenario "non-admin user" do
    sign_in_user
    visit patients_path
    expect(find(".navbar")).to have_link "All patients"
    expect(find(".navbar")).to have_link "#{@user.email}"
    expect(find(".navbar")).to have_link "Sign out"
    expect(find(".navbar")).not_to have_link "Manage users"
    expect(find(".navbar")).to have_link "Export all patient data to CSV"
  end

  scenario "admin user" do
    sign_in_admin
    visit patients_path
    expect(find(".navbar")).to have_link "All patients"
    expect(find(".navbar")).to have_link "#{@admin.email}"
    expect(find(".navbar")).to have_link "Sign out"
    expect(find(".navbar")).to have_link "Manage users"
    expect(find(".navbar")).to have_link "Export all patient data to CSV"
  end

  after :each do
    sign_out
  end
end

feature "patient records page navigation" do
  before :each do
    @patient = Patient.create name: "name", diagnosis: "diagnosis"
  end

  scenario "non-admin user" do
    sign_in_user
    visit patients_path(@patient.id)
    expect(find(".navbar")).to have_link "All patients"
    expect(find(".navbar")).to have_link "#{@user.email}"
    expect(find(".navbar")).to have_link "Sign out"
    expect(find(".navbar")).not_to have_link "Manage users"
    expect(find(".navbar")).to have_link "Export data for #{@patient.name} to CSV"
  end

  scenario "admin user" do
    sign_in_admin
    visit patients_path(@patient.id)
    expect(find(".navbar")).to have_link "All patients"
    expect(find(".navbar")).to have_link "#{@admin.email}"
    expect(find(".navbar")).to have_link "Sign out"
    expect(find(".navbar")).to have_link "Manage users"
    expect(find(".navbar")).to have_link "Export data for #{@patient.name} to CSV"
  end

  after :each do
    sign_out
  end
end
