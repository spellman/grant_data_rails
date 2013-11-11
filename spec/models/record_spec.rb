require "spec_helper"

describe Record do
  before :each do
    @patient = Patient.create name: "name", diagnosis: "diagnosis"
    @with_valid_id              = { patient_id: @patient.id }
    @with_invalid_id            = { patient_id: -1 }
    @with_no_id                 = {}
    @with_valid_domain_fields   = { a1c: 1 }
    @with_invalid_domain_fields = {}
  end

  it "has a valid patient_id" do
    with_valid_id   = @with_valid_id.merge @with_valid_domain_fields
    with_invalid_id = @with_invalid_id.merge @with_valid_domain_fields
    with_no_id      = @with_no_id.merge @with_valid_domain_fields
    expect(Record.new with_valid_id).to be_valid
    expect(Record.new with_invalid_id).not_to be_valid
    expect(Record.new with_no_id).not_to be_valid
  end

  it "has some non-blank domain field" do
    with_valid_domain_fields = @with_valid_domain_fields.merge @with_valid_id
    with_invalid_domain_fields = @with_invalid_domain_fields.merge @with_valid_id
    expect(Record.new with_valid_domain_fields).to be_valid
    expect(Record.new with_invalid_domain_fields).not_to be_valid
  end
end
