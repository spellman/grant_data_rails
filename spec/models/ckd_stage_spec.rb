require "spec_helper"

describe CkdStage do
  before :each do
    @valid_patient   = Patient.create name: "name", diagnosis: "diagnosis"
    @valid_date      = Time.zone.local 2013, 1, 1
    @valid_ckd_stage = 1
  end

  it "requires a valid patient" do
    valid_patient   = CkdStage.new patient_id: @valid_patient.id,
                                   ckd_stage:  @valid_ckd_stage,
                                   date:       @valid_date
    no_patient      = CkdStage.new ckd_stage: @valid_ckd_stage,
                                   date:      @valid_date
    invalid_patient = CkdStage.new patient_id: -1,
                                   ckd_stage:  @valid_ckd_stage,
                                   date:       @valid_date
    expect(valid_patient).to be_valid

    expect(no_patient).to be_invalid
    expect(no_patient.errors.messages[:patient_id]).to include "can't be blank"
    expect(no_patient.errors.messages[:patient_id]).to include "must be valid"

    expect(invalid_patient).to be_invalid
    expect(invalid_patient.errors.messages[:patient_id]).to include "must be valid"
  end

  it "requires a valid date" do
    valid_date   = @valid_patient.ckd_stages.build ckd_stage: @valid_ckd_stage,
                                                   date:      Time.zone.local(2013, 1, 1)
    no_date      = @valid_patient.ckd_stages.build ckd_stage: @valid_ckd_stage
    invalid_date = @valid_patient.ckd_stages.build ckd_stage: @valid_ckd_stage,
                                                   date:      "foo"
    expect(valid_date).to be_valid
    expect(no_date).to be_invalid
    expect(invalid_date).to be_invalid
  end

  it "requires a non-negative integer value" do
    valid_ckd_stage       = @valid_patient.ckd_stages.build ckd_stage: @valid_ckd_stage,
                                                            date:      @valid_date
    no_ckd_stage          = @valid_patient.ckd_stages.build date:      @valid_date
    negative_ckd_stage    = @valid_patient.ckd_stages.build ckd_stage: -1,
                                                            date:      @valid_date
    non_integer_ckd_stage = @valid_patient.ckd_stages.build ckd_stage: 1.5,
                                                            date:      @valid_date
    expect(valid_ckd_stage).to be_valid
    expect(no_ckd_stage).to be_invalid
    expect(negative_ckd_stage).to be_invalid
    expect(non_integer_ckd_stage).to be_invalid
  end
end
