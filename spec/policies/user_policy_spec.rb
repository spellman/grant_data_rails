require "spec_helper"

describe UserPolicy do

  it "permits admin users to create new users" do
    admin  = User.new admin: true
    user   = User.new
    policy = UserPolicy.new admin, user
    expect(policy).to permit :create
  end

  it "does not permit non-admin users to create new users" do
    admin  = User.new admin: false
    user   = User.new
    policy = UserPolicy.new admin, user
    expect(policy).to_not permit :create
  end

end
