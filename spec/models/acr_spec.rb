require "spec_helper"

describe Acr do
  before :each do
    @valid_patient = Patient.create name: "name", diagnosis: "diagnosis"
    @valid_date    = Time.zone.local 2013, 1, 1
    @valid_acr     = 1
  end

  it "requires a valid patient" do
    valid_patient   = Acr.new patient_id: @valid_patient.id,
                              acr:        @valid_acr,
                              date:       @valid_date
    no_patient      = Acr.new acr:        @valid_acr,
                              date:       @valid_date
    invalid_patient = Acr.new patient_id: -1,
                              acr:        @valid_acr,
                              date:       @valid_date
    expect(valid_patient).to be_valid

    expect(no_patient).to be_invalid
    expect(no_patient.errors.messages[:patient_id]).to include "can't be blank"
    expect(no_patient.errors.messages[:patient_id]).to include "must be valid"

    expect(invalid_patient).to be_invalid
    expect(invalid_patient.errors.messages[:patient_id]).to include "must be valid"
  end

  it "requires a valid date" do
    valid_date   = @valid_patient.acrs.build acr:  @valid_acr,
                                             date: Time.zone.local(2013, 1, 1)
    no_date      = @valid_patient.acrs.build acr:  @valid_acr
    invalid_date = @valid_patient.acrs.build acr:  @valid_acr,
                                             date: "foo"
    expect(valid_date).to be_valid
    expect(no_date).to be_invalid
    expect(invalid_date).to be_invalid
  end

  it "requires a non-negative integer value" do
    valid_acr       = @valid_patient.acrs.build acr: @valid_acr, date: @valid_date
    no_acr          = @valid_patient.acrs.build                  date: @valid_date
    negative_acr    = @valid_patient.acrs.build acr: -1,         date: @valid_date
    non_integer_acr = @valid_patient.acrs.build acr:  1.5,       date: @valid_date
    expect(valid_acr).to be_valid
    expect(no_acr).to be_invalid
    expect(negative_acr).to be_invalid
    expect(non_integer_acr).to be_invalid
  end
end
