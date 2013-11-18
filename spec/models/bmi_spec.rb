require "spec_helper"

describe Bmi do
  before :each do
    @valid_patient = Patient.create name: "name", diagnosis: "diagnosis"
    @valid_date    = Time.zone.local 2013, 1, 1
    @valid_bmi     = 1.5
  end

  it "requires a valid patient" do
    valid_patient   = Bmi.new patient_id: @valid_patient.id,
                              bmi:        @valid_bmi,
                              date:       @valid_date
    no_patient      = Bmi.new bmi:        @valid_bmi,
                              date:       @valid_date
    invalid_patient = Bmi.new patient_id: -1,
                              bmi:        @valid_bmi,
                              date:       @valid_date
    expect(valid_patient).to be_valid

    expect(no_patient).to be_invalid
    expect(no_patient.errors.messages[:patient_id]).to include "can't be blank"
    expect(no_patient.errors.messages[:patient_id]).to include "must be valid"

    expect(invalid_patient).to be_invalid
    expect(invalid_patient.errors.messages[:patient_id]).to include "must be valid"
  end

  it "requires a valid date" do
    valid_date   = @valid_patient.bmis.build bmi:  @valid_bmi,
                                             date: Time.zone.local(2013, 1, 1)
    no_date      = @valid_patient.bmis.build bmi:  @valid_bmi
    invalid_date = @valid_patient.bmis.build bmi:  @valid_bmi,
                                             date: "foo"
    expect(valid_date).to be_valid
    expect(no_date).to be_invalid
    expect(invalid_date).to be_invalid
  end

  it "requires a non-negative number value" do
    valid_bmi    = @valid_patient.bmis.build bmi: @valid_bmi, date: @valid_date
    no_bmi       = @valid_patient.bmis.build                  date: @valid_date
    negative_bmi = @valid_patient.bmis.build bmi: -1,         date: @valid_date
    expect(valid_bmi).to be_valid
    expect(no_bmi).to be_invalid
    expect(negative_bmi).to be_invalid
  end
end
