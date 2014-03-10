require "spec_helper"

describe A1c do
  before :each do
    @pt = Patient.create study_assigned_id: 1, birthdate: Date.new(1900, 1, 13)
    @valid_date = Date.new 2000, 1, 13
    @valid_a1c_value = 1.5
    @us_date_format = "%-m/%d/%Y"
  end

  it "is valid with a unique combination of valid patient and valid date, and a non-negative a1c value" do
    valid_info = {
      patient_id: @pt.id,
      date: Date.new(2000, 1, 13),
      a1c: 0
    }
    expect(A1c.new valid_info).to be_valid
  end

  specify "patient id must be valid" do
    a1c_with_invalid_patient_id = A1c.new patient_id: -1,
                                          date: @valid_date,
                                          a1c: @valid_a1c_value
    expect(a1c_with_invalid_patient_id).to be_invalid
    expect(a1c_with_invalid_patient_id.errors.messages[:patient_id]).to include "must be valid"
  end

  specify "patient id cannot be blank" do
    a1c_with_no_patient_id = A1c.new date: @valid_date,
                                     a1c: @valid_a1c_value
    expect(a1c_with_no_patient_id).to be_invalid
    expect(a1c_with_no_patient_id.errors.messages[:patient_id]).to include "can't be blank"
    expect(a1c_with_no_patient_id.errors.messages[:patient_id]).to include "must be valid"
  end

  specify "date cannot be in the future" do
    pending "not yet implemented"
  end

  specify "date cannot preceed patient birthdate" do
    pending "not yet implemented"
  end

  specify "date must be a date" do
    number_date = {
      patient_id: @pt.id,
      date: 1,
      a1c: 1
    }
    expect(A1c.new number_date).to be_invalid
  end

  specify "date cannot be nil" do
    no_date = {
      a1c: @valid_a1c_value
    }
    expect(@pt.a1cs.build no_date).to be_invalid
  end

  specify "combination of patient id and date must be unique" do
    pending "not yet implemented"
    unique_combination = {
      patient_id: @pt.id,
      date: Date.new(2000, 1, 13),
      a1c: @valid_a1c_value
    }
    non_unique_combination = {
      patient_id: @pt.id,
      date: Date.new(2000, 1, 13),
      a1c: @valid_a1c_value
    }
    A1c.create unique_combination
    expect(A1c.new non_unique_combination).to be_invalid
  end

  specify "a1c value must be non-negative" do
    negative_a1c = {
      date: @valid_date,
      a1c: -1
    }
    expect(@pt.a1cs.build negative_a1c).to be_invalid
  end

  specify "a1c value cannot be blank" do
    no_a1c = {
      date: @valid_date
    }
    expect(@pt.a1cs.build no_a1c).to be_invalid
  end

  specify "i18n_alchemy-localized proxy accepts mm/dd/yyyy date string under en locale" do
    a1c = @pt.a1cs.build a1c: @valid_a1c_value
    expect{ a1c.localized.date = @valid_date.strftime(@us_date_format) }.not_to raise_error
    expect(a1c.date).to eq @valid_date
    expect(a1c).to be_valid
  end
end
