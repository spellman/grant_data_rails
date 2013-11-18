require "spec_helper"

describe Renal do
  before :each do
    @valid_patient    = Patient.create name: "name", diagnosis: "diagnosis"
    @valid_date       = Time.zone.local 2013, 1, 1
    @valid_bun        = 1
    @valid_creatinine = 1
  end

  it "requires a valid patient" do
    valid_patient   = Renal.new patient_id: @valid_patient.id,
                                bun:        @valid_bun,
                                date:       @valid_date
    no_patient      = Renal.new bun:        @valid_bun,
                                date:       @valid_date
    invalid_patient = Renal.new patient_id: -1,
                                bun:        @valid_bun,
                                date:       @valid_date
    expect(valid_patient).to be_valid

    expect(no_patient).to be_invalid
    expect(no_patient.errors.messages[:patient_id]).to include "can't be blank"
    expect(no_patient.errors.messages[:patient_id]).to include "must be valid"

    expect(invalid_patient).to be_invalid
    expect(invalid_patient.errors.messages[:patient_id]).to include "must be valid"
  end

  it "requires a valid date" do
    valid_date   = @valid_patient.renals.build bun:  @valid_bun,
                                               date: Time.zone.local(2013, 1, 1)
    no_date      = @valid_patient.renals.build bun:  @valid_bun
    invalid_date = @valid_patient.renals.build bun:  @valid_bun,
                                               date: "foo"
    expect(valid_date).to be_valid
    expect(no_date).to be_invalid
    expect(invalid_date).to be_invalid
  end

  it "requires at least one of bun, creatinine" do
    no_values = @valid_patient.renals.build date: @valid_date
    expect(no_values).to be_invalid
  end

  it "requires bun, creatinine to be non-negative integers if given" do
    valid_values      = @valid_patient.renals.build bun:        @valid_bun,
                                                    date:       @valid_date
    negative_value    = @valid_patient.renals.build bun:        -1,
                                                    date:       @valid_date
    non_integer_value = @valid_patient.renals.build creatinine:  1.5,
                                                    date:       @valid_date
    expect(valid_values).to be_valid
    expect(negative_value).to be_invalid
    expect(non_integer_value).to be_invalid
  end
end
