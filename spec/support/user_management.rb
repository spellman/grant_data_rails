module UserManagement

  def create_test_users
    User.create email: "admin@test.com", password: "password!", admin: true unless User.find_by_email "admin@test.com"
    User.create email: "user@test.com", password: "password!", admin: false unless User.find_by_email "user@test.com"
  end

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
    within "#new_user" do
      fill_in "user_email", with: email
      fill_in "user_password", with: password
      click_button "Sign in"
    end
  end

  def sign_out
    visit root_path
    click_link "Sign out"
  end

end
