require "spec_helper"
require "not_all_domain_fields_blank_validator"

describe NotAllDomainFieldsBlankValidator do
  class NotAllDomainFieldsBlankValidatorTester
    include ActiveModel::Validations

    attr_reader :attributes
    
    def initialize attributes = {}
      @attributes = attributes
    end
  end

  before :each do
    @validator = NotAllDomainFieldsBlankValidator.new domain_fields: [:foo, :bar]
  end

  it "adds no error if some domain field is not blank" do
    all_fields = NotAllDomainFieldsBlankValidatorTester.new foo:  "baz",
                                                                   sneh: "bah"
    @validator.validate all_fields
    expect(all_fields.errors.messages).to be_empty
  end

  it "adds an error if all domain fields are blank" do
    missing_domain_field = NotAllDomainFieldsBlankValidatorTester.new sneh: "bah"
    @validator.validate missing_domain_field
    expect(missing_domain_field.errors.messages[:base].length).to eq 1
  end

  it "differentiates domain fields from non-domain fields" do
    missing_non_domain_field = NotAllDomainFieldsBlankValidatorTester.new foo:  "baz",
                                                                                 bar:  "quux"
    @validator.validate missing_non_domain_field
    expect(missing_non_domain_field.errors.messages).to be_empty
  end
end
