require "spec_helper"

describe NotAllDomainFieldsBlankValidator do
  class NotAllDomainFieldsBlankValidatorTester
    include ActiveModel::Validations
    include ActiveModel::Conversion
    extend ActiveModel::Naming
    attr_accessor :attributes, :foo, :bar, :sneh
    validates_with NotAllDomainFieldsBlankValidator, domain_fields: ["foo", "bar"]
    
    def initialize attributes = {}
      attributes.each do |name, value|
        send "#{name}=", value
      end
      @attributes = Hash[attributes.map { |k, v| [k.to_s, v] }]
    end

    def persisted?
      false
    end
  end

  it "adds no error if some domain field is not blank" do
    all_fields = NotAllDomainFieldsBlankValidatorTester.new foo:  "baz",
                                                            sneh: "bah"
    all_fields.valid?
    expect(all_fields.errors.any?).to eq false
  end

  it "adds an error if all domain fields are blank" do
    no_domain_fields = NotAllDomainFieldsBlankValidatorTester.new sneh: "bah"
    no_domain_fields.valid?
    expect(no_domain_fields.errors.messages[:base].length).to eq 1
  end

  it "differentiates domain fields from non-domain fields" do
    missing_non_domain_field = NotAllDomainFieldsBlankValidatorTester.new foo: "baz"
    missing_non_domain_field.valid?
    expect(missing_non_domain_field.errors.any?).to eq false
  end
end
