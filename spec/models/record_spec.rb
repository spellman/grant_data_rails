require "spec_helper"

describe Record do

  it "has a name" do
    user = User.create email: "user@temp.com", password: "11111111"
    valid_name = { name: "foo" }
    no_name    = {}
    expect(Record.new valid_name).to be_valid
    expect(Record.new no_name).not_to be_valid
  end

  it "does not destroy records created by a user if the user is destroyed" do
    user = User.create email: "user@temp.com", password: "11111111"
    Record.create({ name: "foo", created_by: user.email })
    user.destroy
    expect(Record.all).to have(1).record
  end

end
