require "spec_helper"

describe Patient do
  before :each do
    @with_valid_name        = { name: "string" }
    @with_invalid_name      = { name: "" }
    @with_no_name           = {}
    @with_valid_diagnosis   = { diagnosis: "string" }
    @with_invalid_diagnosis = { diagnosis: "" }
    @with_no_diagnosis      = {}
  end

  it "has a name" do
    with_valid_name   = @with_valid_name.merge @with_valid_diagnosis
    with_invalid_name = @with_invalid_name.merge @with_valid_diagnosis
    with_no_name      = @with_no_name.merge @with_valid_diagnosis
    expect(Patient.new with_valid_name).to be_valid
    expect(Patient.new with_invalid_name).to be_invalid
    expect(Patient.new with_no_name).to be_invalid
  end

  it "has a diagnosis" do
    with_valid_diagnosis   = @with_valid_diagnosis.merge @with_valid_name
    with_invalid_diagnosis = @with_invalid_diagnosis.merge @with_valid_name
    with_no_diagnosis      = @with_no_diagnosis.merge @with_valid_name
    expect(Patient.new with_valid_diagnosis).to be_valid
    expect(Patient.new with_invalid_diagnosis).to be_invalid
    expect(Patient.new with_no_diagnosis).to be_invalid
  end
end
