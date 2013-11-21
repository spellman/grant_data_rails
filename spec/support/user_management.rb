module UserManagement
  def sign_in_user
    initialize_test_users
    sign_in email:    @user.email,
            password: "password!"
  end
  
  def sign_in_admin
    initialize_test_users
    sign_in email:    @admin.email,
            password: "password!"
  end

  def initialize_test_users
    @user  = User.find_by email: "user@test.com"
    @admin = User.find_by email: "admin@test.com"
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
    visit patients_path
    click_link "Sign out"
  end
end
