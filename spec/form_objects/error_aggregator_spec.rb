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
    expected = no_name.errors.full_messages + invalid.errors.full_messages
    expect(aggregator.aggregate_errors_from [no_name, invalid]).to be_an ErrorAggregator
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
    expect(aggregator.add_full_error_message "foo").to be_an ErrorAggregator
    expect(aggregator.full_messages).to eq Set.new(["foo"])
  end

  it "forwards #any? to full_messages" do
    no_name = ErrorAggregatorTester.new
    no_name.valid?
    aggregator = ErrorAggregator.new
    expect(aggregator.any?).to eq false
    aggregator.aggregate_errors_from [no_name]
    expect(aggregator.full_messages).not_to be_empty
    expect(aggregator.any?).to eq true
  end

  it "forwards #count to full_messages" do
    no_name = ErrorAggregatorTester.new
    no_name.valid?
    aggregator = ErrorAggregator.new
    expect(aggregator.count).to eq 0
    aggregator.aggregate_errors_from [no_name]
    expect(aggregator.full_messages).not_to be_empty
    expect(aggregator.count).to eq no_name.errors.count
  end
end
