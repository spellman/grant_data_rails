require "spec_helper"

describe Record do
  it "has a valid patient_id" do
    patient    = Patient.create name: "name", diagnosis: "diagnosis"
    with_valid_id   = { patient_id: patient.id }
    with_invalid_id = { patient_id: -1 }
    with_no_id      = {}
    expect(Record.new with_valid_id).to be_valid
    expect(Record.new with_invalid_id).not_to be_valid
    expect(Record.new with_no_id).not_to be_valid
  end
end
