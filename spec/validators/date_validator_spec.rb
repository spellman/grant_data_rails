require "spec_helper"
require "date_validator"

describe DateValidator do
  class DateValidatorTester
    include ActiveModel::Validations

    attr_reader :attributes, :date
    
    def initialize attributes = {}
      @attributes = attributes
      @date       = attributes[:date]
    end

    validates :date,
      date: true
  end

  it "adds no errors when given a Date" do
    date      = DateValidatorTester.new date: Date.new(2013, 1, 1)
    date_time = DateValidatorTester.new date: DateTime.new(2013, 1, 1)
    expect(date).to be_valid
    expect(date_time).to be_valid
  end

  it "adds errors when given something other than a Date" do
    time_with_zone = DateValidatorTester.new date: Time.zone.local(2013, 1, 1)
    time           = DateValidatorTester.new date: Time.new(2013, 1, 1)
    string         = DateValidatorTester.new date: "1/1/2013"
    expect(time_with_zone).to be_invalid
    expect(time).to be_invalid
    expect(string).to be_invalid
  end
end
