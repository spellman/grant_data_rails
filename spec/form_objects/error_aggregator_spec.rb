require "spec_helper"

describe ErrorAggregator do
  class ErrorAggregatorTester
    include ActiveModel::Validations
    include ActiveModel::Conversion
    extend ActiveModel::Naming
    attr_accessor :name, :id, :error_aggregator_tester
    validates :name,
      presence: true
    validates :error_aggregator_tester,
      numericality: true,
      allow_blank: true
    validate :id_positive_integer_or_blank

    def initialize attributes = {}
      attributes.each do |name, value|
        send "#{name}=", value
      end
    end

    def id_positive_integer_or_blank
      unless id.blank? || (id.is_a?(Numeric) && id > 0 && id == id.to_i)
        errors.add :base, "Id must be a positive integer if specified" 
      end
    end

    def persisted?
      false
    end
  end

  it "aggregates messages from multiple ActiveModel::Errors objects" do
    tester_1 = ErrorAggregatorTester.new error_aggregator_tester: "non-numeric a"
    tester_2 = ErrorAggregatorTester.new error_aggregator_tester: "non-numeric b"
    tester_1.valid?
    tester_2.valid?
    testers  = {
      "tester_1" => tester_1,
      "tester_2" => tester_2
    }
    aggregator = ErrorAggregator.new(testers).aggregate_errors
    expected_messages = {
      tester_1: tester_1.errors.messages,
      tester_2: tester_2.errors.messages
    }
    expect(tester_1.errors.messages.count).to eq 2
    expect(tester_2.errors.messages.count).to eq 2
    expect(aggregator.errors.messages).to eq expected_messages
  end

  it "generates full messages from messages" do
    tester_1 = ErrorAggregatorTester.new
    tester_2 = ErrorAggregatorTester.new
    tester_1.valid?
    tester_2.valid?
    testers  = {
      "tester_1" => tester_1,
      "tester_2" => tester_2
    }
    aggregator = ErrorAggregator.new(testers).aggregate_errors
    expected_messages = [
      "Tester 1 Name " + tester_1.errors.messages[:name].first,
      "Tester 2 Name " + tester_2.errors.messages[:name].first
    ]
    expect(tester_1.errors.messages.count).to eq 1
    expect(tester_2.errors.messages.count).to eq 1
    expect(aggregator.errors.full_messages).to eq expected_messages
  end

  it "includes the specified model name and the attribute name in the full message when they differ, mod formatting" do
    tester = ErrorAggregatorTester.new
    tester.valid?
    testers  = {
      "tester" => tester
    }
    aggregator = ErrorAggregator.new(testers).aggregate_errors
    expected_messages = [
      "Tester Name " + tester.errors.messages[:name].first
    ]
    expect(tester.errors.messages.count).to eq 1
    expect(aggregator.errors.full_messages).to eq expected_messages
  end

  it "includes the specified model name; not the class of the model" do
    tester = ErrorAggregatorTester.new
    tester.valid?
    testers  = {
      "foo" => tester
    }
    aggregator = ErrorAggregator.new(testers).aggregate_errors
    expected_messages = [
      "Foo Name " + tester.errors.messages[:name].first
    ]
    expect(tester.errors.messages.count).to eq 1
    expect(aggregator.errors.full_messages).to eq expected_messages
  end

  it "includes the specified model name / attribute name only once in the full message when they are the same, mod formatting" do
    tester = ErrorAggregatorTester.new name:                    "valid",
                                         error_aggregator_tester: "non-numeric"
    tester.valid?
    testers  = {
      "error_aggregator_tester" => tester
    }
    aggregator = ErrorAggregator.new(testers).aggregate_errors
    expected_messages = [
      "error aggregator tester " + tester.errors.messages[:error_aggregator_tester].first
    ]
    expect(tester.errors.messages.count).to eq 1
    expect(aggregator.errors.full_messages.map(&:downcase)).to eq expected_messages
  end

  it "titlecases the model and attribute names" do
    tester = ErrorAggregatorTester.new
    tester.valid?
    testers  = {
      "tester" => tester
    }
    aggregator = ErrorAggregator.new(testers).aggregate_errors
    expected_messages = [
      "Tester Name " + tester.errors.messages[:name].first
    ]
    expect(tester.errors.messages.count).to eq 1
    expect(aggregator.errors.full_messages).to eq expected_messages
  end
end
