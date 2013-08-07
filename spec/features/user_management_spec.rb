require "spec_helper"
include SignInAndOut

feature "user management" do

  scenario "a guest user cannot sign up" do
    visit new_user_path
    expect(page).to have_content("Sign in")
  end

  scenario "an admin can create additional users" do
    sign_in_admin
    visit new_user_path
    expect(page).to have_content("Password confirmation")
  end

  scenario "a non-admin user cannot create additional users" do
    sign_in_user
    visit new_user_path
    expect(page).to have_content("You are not authorized to perform this action.")
  end

end
