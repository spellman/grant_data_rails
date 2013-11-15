require "spec_helper"

describe Renal do
  before :each do
    @valid_patient    = Patient.create name: "name", diagnosis: "diagnosis"
    @valid_date       = Time.zone.local 2013, 1, 1
    @valid_bun        = 1
    @valid_creatinine = 1
  end

  it "requires a valid patient" do
    valid_patient   = Renal.new patient_id: @valid_patient.id, bun: @valid_bun, date: @valid_date
    no_patient      = Renal.new                                bun: @valid_bun, date: @valid_date
    invalid_patient = Renal.new patient_id: -1,                bun: @valid_bun, date: @valid_date
    expect(valid_patient).to be_valid
    expect(no_patient).to be_invalid
    expect(invalid_patient).to be_invalid
  end

  it "requires a valid date" do
    valid_date   = @valid_patient.renals.build bun: @valid_bun, date: Time.zone.local(2013, 1, 1)
    no_date      = @valid_patient.renals.build bun: @valid_bun
    invalid_date = @valid_patient.renals.build bun: @valid_bun, date: "foo"
    expect(valid_date).to be_valid
    expect(no_date).to be_invalid
    expect(invalid_date).to be_invalid
  end

  it "requires at lebun one of bun, creatinine" do
    valid_values      = @valid_patient.renals.build bun:  @valid_bun,
                                                    date: @valid_date
    all_values        = @valid_patient.renals.build bun:         @valid_bun,
                                                    creatinine:  @valid_creatinine,
                                                    date:        @valid_date
    no_values         = @valid_patient.renals.build                   date: @valid_date
    negative_value    = @valid_patient.renals.build bun:        -1,   date: @valid_date
    non_integer_value = @valid_patient.renals.build creatinine:  1.5, date: @valid_date
    expect(valid_values).to be_valid
    expect(all_values).to be_valid
    expect(no_values).to be_invalid
    expect(negative_value).to be_invalid
    expect(non_integer_value).to be_invalid
  end
end
