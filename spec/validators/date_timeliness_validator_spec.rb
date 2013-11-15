require "spec_helper"
require "date_timeliness_validator"

describe DateTimelinessValidator do
  class DateTimelinessValidatorTester
    include ActiveModel::Validations

    attr_reader :attributes, :date
    
    def initialize attributes = {}
      @attributes = attributes
      @date       = attributes[:date]
    end

    validates :date,
      date_timeliness: true
  end

  it "adds no errors when given an ActiveSupport::TimeWithZone" do
    time_with_zone = DateTimelinessValidatorTester.new date: Time.zone.local(2013, 1, 1)
    expect(time_with_zone).to be_valid
  end

  it "adds an errors when given something other than an ActiveSupport::TimeWithZone" do
    string    = DateTimelinessValidatorTester.new date: "1/1/2013"
    date_time = DateTimelinessValidatorTester.new date: DateTime.new(2013, 1, 1)
    expect(date_time).to be_invalid
    expect(string).to be_invalid
  end
end
