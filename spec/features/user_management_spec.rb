require "spec_helper"
include UserManagement

feature "user management" do

  scenario "a guest user cannot sign up" do
    visit users_path
    expect(page).to have_content "Sign in"
  end

  scenario "an admin can create additional users" do
    sign_in_admin
    visit users_path
    expect(page).to have_content "Password confirmation"
  end

  scenario "a non-admin user cannot create additional users" do
    sign_in_user
    visit users_path
    expect(page).to have_content "You are not authorized to perform this action."
  end

  scenario "an admin can view all users" do
    sign_in_admin
    visit users_path
    expect(page).to have_content "admin@test.com"
    expect(page).to have_content "user@test.com"
  end

  scenario "a non-admin user cannot view all users" do
    sign_in_user
    visit users_path
    expect(page).to have_content "You are not authorized to perform this action."
  end

  scenario "an admin can delete other users" do
    sign_in_admin
    visit users_path
    expect(page).to have_link "delete", href: user_path(2)
  end

  scenario "an admin cannot delete himself" do
    sign_in_admin
    visit users_path
    expect(page).to_not have_link "delete", href: user_path(1)
  end

  scenario "an admin can update other users" do
    temp_user = User.create email: "temp@user.com", password: "11111111"
    sign_in_admin
    visit users_path
    all("a").select { |a| a[:href] == "/users/#{temp_user.id}" }.first.click
    fill_in "user_email", with: "temp@updated.com"
    fill_in "user_password", with: "11111111"
    fill_in "user_password_confirmation", with: "11111111"
    click_button "Update"
    expect(page).to have_content "temp@updated.com"
    expect(page).to_not have_content "temp@user.com"
  end

  scenario "a non-admin user cannot update other users" do
    sign_in_user
    visit user_path(1)
    expect(page).to have_content "You are not authorized to perform this action."

    visit user_path(-1)
    expect(page).to have_content "You are not authorized to perform this action."
  end

  scenario "an admin can update himself" do
    sign_in_admin
    visit user_path(1)
    expect(page).to have_button "Update"
  end

  scenario "a non-admin user can update himself" do
    sign_in_user
    visit user_path(2)
    expect(page).to have_button "Update"
  end

end
