require "spec_helper"

describe Liver do
  before :each do
    @valid_patient  = Patient.create name: "name", diagnosis: "diagnosis"
    @valid_date     = Time.zone.local 2013, 1, 25
    @valid_ast      = 1
    @valid_alt      = 1
    @us_date_format = "%-m/%d/%Y"
  end

  it "requires a valid patient" do
    valid_patient   = Liver.new patient_id: @valid_patient.id,
                                ast:        @valid_ast,
                                date:       @valid_date
    no_patient      = Liver.new ast:        @valid_ast,
                                date:       @valid_date
    invalid_patient = Liver.new patient_id: -1,
                                ast:        @valid_ast,
                                date:       @valid_date
    expect(valid_patient).to be_valid

    expect(no_patient).to be_invalid
    expect(no_patient.errors.messages[:patient_id]).to include "can't be blank"
    expect(no_patient.errors.messages[:patient_id]).to include "must be valid"

    expect(invalid_patient).to be_invalid
    expect(invalid_patient.errors.messages[:patient_id]).to include "must be valid"
  end

  it "requires a valid date" do
    valid_date   = @valid_patient.livers.build ast:  @valid_ast,
                                               date: @valid_date
    no_date      = @valid_patient.livers.build ast:  @valid_ast
    invalid_date = @valid_patient.livers.build ast:  @valid_ast,
                                               date: "foo"
    expect(valid_date).to be_valid
    expect(no_date).to be_invalid
    expect(invalid_date).to be_invalid
  end

  specify "i18n_alchemy-localized proxy accepts mm/dd/yyyy date string under en locale" do
    liver = @valid_patient.livers.build ast: @valid_ast
    expect{ liver.localized.date = @valid_date.strftime(@us_date_format) }.not_to raise_error
    expect(liver.date).to eq @valid_date
    expect(liver).to be_valid
  end

  it "requires at least one of ast, alt" do
    no_values = @valid_patient.livers.build date: @valid_date
    expect(no_values).to be_invalid
  end

  it "requires ast, alt to be non-negative integers if given" do
    valid_values      = @valid_patient.livers.build ast:  @valid_ast,
                                                    date: @valid_date
    negative_value    = @valid_patient.livers.build ast: -1,   date: @valid_date
    non_integer_value = @valid_patient.livers.build alt:  1.5, date: @valid_date
    expect(valid_values).to be_valid
    expect(negative_value).to be_invalid
    expect(non_integer_value).to be_invalid
  end
end
