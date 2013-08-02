require "spec_helper"

describe Record do

  it "has a name" do
    params_with_name = { name: "foo" }
    params_with_blank_name = { name: "" }
    params_with_nil_name = { name: nil }
    params_without_name = {}
    expect(Record.new params_with_name).to be_valid
    expect(Record.new params_with_blank_name).to_not be_valid
    expect(Record.new params_with_nil_name).to_not be_valid
    expect(Record.new params_without_name).to_not be_valid
  end

end
