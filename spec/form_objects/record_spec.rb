require "spec_helper"

describe Record do
  before :each do
    @valid_patient = Patient.create name: "name", diagnosis: "diagnosis"
    @valid_date    = Time.zone.local 2013, 1, 1
    @valid_a1c     = { a1c: 1.5, date: @valid_date }
    @valid_flu     = { date: @valid_date }
  end

  it "initializes child models" do
    record       = Record.new "patient_id" => @valid_patient.id,
                              "a1c"        => @valid_a1c
    expected_a1c = @valid_patient.a1cs.build @valid_a1c
    expect(record.a1c).to be_an A1c
    expect(record.a1c.patient_id).to eq expected_a1c.patient_id
    expect(record.a1c.a1c).to eq expected_a1c.a1c
    expect(record.a1c.date).to eq expected_a1c.date
  end

  specify "save validates each child model" do
    valid_record      = Record.new "patient_id" => @valid_patient.id,
                                   "a1c"        => @valid_a1c,
                                   "flu"        => @valid_flu
    invalid_patient   = Record.new "patient_id" => -1,
                                   "flu"        => @valid_flu
    incomplete_models = Record.new "patient_id" => @valid_patient.id,
                                   "a1c"        => { a1c: 1.5 },
                                   "flu"        => @valid_flu,
                                   "renal"      => { date: @valid_date }
    expect(valid_record.save).to be_true
    expect(valid_record.a1c.errors).to be_empty
    expect(valid_record.flu.errors).to be_empty

    expect(incomplete_models.save).to be_false
    expect(incomplete_models.a1c.errors).not_to be_empty
    expect(incomplete_models.renal.errors).not_to be_empty
  end

  specify "save validates that some child model has non-blank fields" do
    blank_record = Record.new "patient_id" => @valid_patient.id
    expect(blank_record.save).to be_false
    expect(blank_record.errors.full_messages).not_to be_empty
  end

  it "aggregates errors from all models on save" do
    a1c_no_date       = { a1c: -3 }
    ckd_stage_no_date = { ckd_stage: 1 }
    invalid = Record.new "patient_id" => @valid_patient.id,
                         "a1c"        => a1c_no_date,
                         "flu"        => @valid_flu,
                         "ckd_stage"  => ckd_stage_no_date
    invalid.save
    a1c       = @valid_patient.a1cs.build a1c_no_date
    ckd_stage = @valid_patient.ckd_stages.build ckd_stage_no_date
    a1c.valid?
    ckd_stage.valid?
    expected_messages = a1c.errors.full_messages + ckd_stage.errors.full_messages
    expect(invalid.errors.full_messages).to eq Set.new(expected_messages)
  end

  specify "save saves all models with non-blank fields if all such models can be saved" do
    valid_record_1 = Record.new "patient_id" => @valid_patient.id,
                                "a1c"        => @valid_a1c,
                                "flu"        => @valid_flu,
                                "liver"      => {}
    valid_record_2 = Record.new "patient_id" => @valid_patient.id,
                                "a1c"        => @valid_a1c,
                                "flu"        => @valid_flu,
                                "liver"      => {}
    valid_record_3 = Record.new "patient_id" => @valid_patient.id,
                                "a1c"        => @valid_a1c,
                                "flu"        => @valid_flu,
                                "liver"      => {}
    expect{ valid_record_1.save }.to change{ @valid_patient.a1cs.count }.by(1)
    expect{ valid_record_2.save }.to change{ @valid_patient.flus.count }.by(1)
    expect{ valid_record_3.save }.not_to change{ @valid_patient.livers.count }
  end
  
  specify "save saves no models if any model with non-blank fields cannot be saved" do
    invalid_record = Record.new "patient_id" => @valid_patient.id,
                                "a1c"        => { a1c: -3 },
                                "flu"        => @valid_flu,
                                "liver"      => {}
    expect{ invalid_record.save }.not_to change{ @valid_patient.a1cs.count }
    expect{ invalid_record.save }.not_to change{ @valid_patient.flus.count }
    expect{ invalid_record.save }.not_to change{ @valid_patient.livers.count }
  end
end
