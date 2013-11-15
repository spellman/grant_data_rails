require "spec_helper"

describe FootExam do
  before :each do
    @valid_patient = Patient.create name: "name", diagnosis: "diagnosis"
    @valid_date    = Time.zone.local 2013, 1, 1
  end

  it "requires a valid patient" do
    valid_patient   = FootExam.new patient_id: @valid_patient.id, date: @valid_date
    no_patient      = FootExam.new                                date: @valid_date
    invalid_patient = FootExam.new patient_id: -1,                date: @valid_date
    expect(valid_patient).to be_valid
    expect(no_patient).to be_invalid
    expect(invalid_patient).to be_invalid
  end

  it "requires a valid date" do
    valid_date   = @valid_patient.foot_exams.build date: Time.zone.local(2013, 1, 1)
    no_date      = @valid_patient.foot_exams.build
    invalid_date = @valid_patient.foot_exams.build date: "foo"
    expect(valid_date).to be_valid
    expect(no_date).to be_invalid
    expect(invalid_date).to be_invalid
  end
end
