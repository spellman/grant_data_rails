require "spec_helper"
require "set"

describe ErrorAggregator do
  class ErrorAggregatorTester
    include ActiveModel::Validations
    include ActiveModel::Conversion
    extend ActiveModel::Naming
    attr_accessor :name, :error_aggregator_tester
    validates :name,
      presence: true
    validates :error_aggregator_tester,
      numericality: true,
      allow_blank: true

    def initialize attributes = {}
      attributes.each do |name, value|
        send "#{name}=", value
      end
    end

    def persisted?
      false
    end
  end

  it "aggregates full messages from multiple models" do
    no_name = ErrorAggregatorTester.new
    invalid = ErrorAggregatorTester.new error_aggregator_tester: "non-numeric"
    no_name.valid?
    invalid.valid?
    aggregator = ErrorAggregator.new
    aggregator.aggregate_errors_from [no_name, invalid]
    expected = no_name.errors.full_messages + invalid.errors.full_messages
    expect(no_name.errors.full_messages.count).to eq 1
    expect(invalid.errors.full_messages.count).to eq 2
    expect(aggregator.full_messages).to eq Set.new(expected)
  end

  it "stores only unique errors" do
    no_name_1 = ErrorAggregatorTester.new
    no_name_2 = ErrorAggregatorTester.new
    no_name_1.valid?
    no_name_2.valid?
    aggregator = ErrorAggregator.new
    aggregator.aggregate_errors_from [no_name_1, no_name_2]
    expected = no_name_1.errors.full_messages
    expect(no_name_1.errors.full_messages.count).to eq 1
    expect(no_name_2.errors.full_messages.count).to eq 1
    expect(aggregator.full_messages).to eq Set.new(expected)
  end

  it "allows adding full messages directly" do
    aggregator = ErrorAggregator.new
    aggregator.add_full_error_message "foo"
    expect(aggregator.full_messages).to eq Set.new(["foo"])
  end
end
