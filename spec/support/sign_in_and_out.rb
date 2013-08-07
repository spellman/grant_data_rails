module SignInAndOut

  def sign_in_user
    sign_in email:    "user@test.com",
            password: "password!"
  end
  
  def sign_in_admin
    sign_in email:    "admin@test.com",
            password: "password!"
  end

  def sign_in email: nil, password: nil
    visit new_user_session_path
    within("#new_user") do
      fill_in "user_email", with: email
      fill_in "user_password", with: password
      click_button "Sign in"
    end
  end

  def sign_out
    visit root_path
    within("#user_panel") do
      click_link "Sign out"
    end
  end

end
