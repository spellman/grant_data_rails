require "spec_helper"

describe A1c do
  before :each do
    @valid_patient  = Patient.create name: "name", diagnosis: "diagnosis"
    @valid_date     = Time.zone.local 2013, 1, 25
    @valid_a1c      = 1.5
    @us_date_format = "%-m/%d/%Y"
  end

  it "requires a valid patient" do
    valid_patient   = A1c.new patient_id: @valid_patient.id,
                              a1c:        @valid_a1c,
                              date:       @valid_date
    no_patient      = A1c.new a1c:        @valid_a1c,
                              date:       @valid_date
    invalid_patient = A1c.new patient_id: -1,
                              a1c:        @valid_a1c,
                              date:       @valid_date
    expect(valid_patient).to be_valid

    expect(no_patient).to be_invalid
    expect(no_patient.errors.messages[:patient_id]).to include "can't be blank"
    expect(no_patient.errors.messages[:patient_id]).to include "must be valid"

    expect(invalid_patient).to be_invalid
    expect(invalid_patient.errors.messages[:patient_id]).to include "must be valid"
  end

  it "requires a valid date" do
    valid_date   = @valid_patient.a1cs.build a1c:  @valid_a1c,
                                             date: @valid_date
    no_date      = @valid_patient.a1cs.build a1c:  @valid_a1c
    invalid_date = @valid_patient.a1cs.build a1c:  @valid_a1c,
                                             date: "foo"
    expect(valid_date).to be_valid
    expect(no_date).to be_invalid
    expect(invalid_date).to be_invalid
  end

  specify "i18n_alchemy-localized proxy accepts mm/dd/yyyy date string under en locale" do
    a1c = @valid_patient.a1cs.build a1c: @valid_a1c
    expect{ a1c.localized.date = @valid_date.strftime(@us_date_format) }.not_to raise_error
    expect(a1c.date).to eq @valid_date
    expect(a1c).to be_valid
  end

  it "requires a non-negative number value" do
    valid_a1c    = @valid_patient.a1cs.build a1c: @valid_a1c, date: @valid_date
    no_a1c       = @valid_patient.a1cs.build                  date: @valid_date
    negative_a1c = @valid_patient.a1cs.build a1c: -1,         date: @valid_date
    expect(valid_a1c).to be_valid
    expect(no_a1c).to be_invalid
    expect(negative_a1c).to be_invalid
  end
end
