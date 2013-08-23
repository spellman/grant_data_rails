module UserManagement

  def sign_in_user
    sign_in email:    "user@test.com",
            password: "password!"
  end
  
  def sign_in_admin
    sign_in email:    "admin@test.com",
            password: "password!"
  end

  def sign_in email: nil, password: nil
    visit signin_path
    within "#signin-form" do
      fill_in "email", with: email
      fill_in "password", with: password
      click_button "Sign in"
    end
  end

  def sign_out
    visit records_path
    click_link "Sign out"
  end

end
