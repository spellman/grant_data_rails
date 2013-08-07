require "spec_helper"
include SignInAndOut

feature "user management" do

  scenario "a guest user cannot sign up" do
    visit new_user_path
    expect(page).to have_content "Sign in"
  end

  scenario "an admin can create additional users" do
    sign_in_admin
    visit new_user_path
    expect(page).to have_content "Password confirmation"

    visit users_path
    expect(page).to have_link "Create new user", href: new_user_path
  end

  scenario "a non-admin user cannot create additional users" do
    sign_in_user
    visit new_user_path
    expect(page).to have_content "You are not authorized to perform this action."
  end

  scenario "an admin can view all users" do
    sign_in_admin
    visit users_path
    expect(page).to have_content "admin@test.com"
    expect(page).to have_content "user@test.com"
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

end
