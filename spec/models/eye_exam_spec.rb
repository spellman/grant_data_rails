require "spec_helper"

describe EyeExam do
  before :each do
    @valid_patient  = Patient.create name: "name", diagnosis: "diagnosis"
    @valid_date     = Date.new 2013, 1, 25
    @us_date_format = "%-m/%d/%Y"
  end

  it "requires a valid patient" do
    valid_patient   = EyeExam.new patient_id: @valid_patient.id, date: @valid_date
    no_patient      = EyeExam.new                                date: @valid_date
    invalid_patient = EyeExam.new patient_id: -1,                date: @valid_date
    expect(valid_patient).to be_valid

    expect(no_patient).to be_invalid
    expect(no_patient.errors.messages[:patient_id]).to include "can't be blank"
    expect(no_patient.errors.messages[:patient_id]).to include "must be valid"

    expect(invalid_patient).to be_invalid
    expect(invalid_patient.errors.messages[:patient_id]).to include "must be valid"
  end

  it "requires a valid date" do
    valid_date   = @valid_patient.eye_exams.build date: @valid_date
    no_date      = @valid_patient.eye_exams.build
    invalid_date = @valid_patient.eye_exams.build date: "foo"
    expect(valid_date).to be_valid
    expect(no_date).to be_invalid
    expect(invalid_date).to be_invalid
  end

  specify "i18n_alchemy-localized proxy accepts mm/dd/yyyy date string under en locale" do
    eye_exam = @valid_patient.eye_exams.build
    expect{ eye_exam.localized.date = @valid_date.strftime(@us_date_format) }.not_to raise_error
    expect(eye_exam.date).to eq @valid_date
    expect(eye_exam).to be_valid
  end
end
