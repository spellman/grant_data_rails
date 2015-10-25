require "spec_helper"

describe Patient do
  before :each do
    @valid_id = 1
    @valid_birthdate = Date.new 2000, 1, 13
  end

  it "is valid with a non-negative, unique integer study-assigned-id" do
    zero_id = {
      study_assigned_id: 0,
      birthdate: @valid_birthdate
    }
    one_id = {
      study_assigned_id: 1,
      birthdate: @valid_birthdate
    }
    two_id = {
      study_assigned_id: 1,
      birthdate: @valid_birthdate
    }
    expect(Patient.new zero_id).to be_valid
    expect(Patient.new one_id).to be_valid
    expect(Patient.new two_id).to be_valid
  end

  specify "study-assigned-id must be unique" do
    valid_id = {
      study_assigned_id: 1,
      birthdate: @valid_birthdate
    }
    non_unique_id = {
      study_assigned_id: 1,
      birthdate: @valid_birthdate
    }
    Patient.create valid_id
    expect(Patient.new non_unique_id).to be_invalid
  end

  specify "study-assigned-id cannot be negative" do
    negative_id = {
      study_assigned_id: -1,
      birthdate: @valid_birthdate
    }
    expect(Patient.new negative_id).to be_invalid
  end

  specify "study-assigned-id must be an integer" do
    non_integer_id = {
      study_assigned_id: 1.5,
      birthdate: @valid_birthdate
    }
    expect(Patient.new non_integer_id).to be_invalid
  end

  it "must have a study-assigned-id" do
    no_id = {
      birthdate: @valid_birthdate
    }
    expect(Patient.new no_id).to be_invalid
  end

  it "is valid with a valid birthdate" do
    valid_birthdate = {
      birthdate: Date.new(2000, 1, 13),
      study_assigned_id: @valid_id
    }
    expect(Patient.new valid_birthdate).to be_valid
  end

  specify "birthdate cannot be in the future" do
    pending "not yet implemented"
  end

  specify "birthdate must be a date" do
    string_birthdate = {
      birthdate: "1/13/2000",
      study_assigned_id: @valid_id
    }
    number_birthdate = {
      birthdate: 1,
      study_assigned_id: @valid_id
    }
    expect(Patient.new string_birthdate).to be_invalid
    expect(Patient.new number_birthdate).to be_invalid
  end

  specify "birthdate cannot be nil" do
    no_birthdate = {
      study_assigned_id: @valid_id
    }
    expect(Patient.new no_birthdate).to be_invalid
  end

  specify "smoker must be bool or nil" do
    pending "not yet implemented"
  end

  specify "etoh must be bool or nil" do
    pending "not yet implemented"
  end
end
