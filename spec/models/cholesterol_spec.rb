require "spec_helper"

describe Cholesterol do
  before :each do
    @valid_patient = Patient.create name: "name", diagnosis: "diagnosis"
    @valid_date    = Time.zone.local 2013, 1, 1
    @valid_tc      = 1
    @valid_tg      = 1
    @valid_hdl     = 1
    @valid_ldl     = 1
  end

  it "requires a valid patient" do
    valid_patient   = Cholesterol.new patient_id: @valid_patient.id,
                                      tc:         @valid_tc,
                                      date:       @valid_date
    no_patient      = Cholesterol.new tc:         @valid_tc,
                                      date:       @valid_date
    invalid_patient = Cholesterol.new patient_id: -1,
                                      tc:         @valid_tc,
                                      date:       @valid_date
    expect(valid_patient).to be_valid

    expect(no_patient).to be_invalid
    expect(no_patient.errors.messages[:patient_id]).to include "can't be blank"
    expect(no_patient.errors.messages[:patient_id]).to include "must be valid"

    expect(invalid_patient).to be_invalid
    expect(invalid_patient.errors.messages[:patient_id]).to include "must be valid"
  end

  it "requires a valid date" do
    valid_date   = @valid_patient.cholesterols.build tc:   @valid_tc,
                                                     date: Time.zone.local(2013, 1, 1)
    no_date      = @valid_patient.cholesterols.build tc:   @valid_tc
    invalid_date = @valid_patient.cholesterols.build tc:   @valid_tc,
                                                     date: "foo"
    expect(valid_date).to be_valid
    expect(no_date).to be_invalid
    expect(invalid_date).to be_invalid
  end

  it "requires at least one of tc, tg, hdl, ldl" do
    no_values = @valid_patient.cholesterols.build date: @valid_date
    expect(no_values).to be_invalid
  end

  it "requires tc, tg, hdl, ldl to be non-negative integers if given" do
    valid_values      = @valid_patient.cholesterols.build tc:   @valid_tc,
                                                          date: @valid_date
    negative_value    = @valid_patient.cholesterols.build hdl:  -1,
                                                          date: @valid_date
    non_integer_value = @valid_patient.cholesterols.build ldl:  1.5,
                                                          date: @valid_date
    expect(valid_values).to be_valid
    expect(negative_value).to be_invalid
    expect(non_integer_value).to be_invalid
  end
end
