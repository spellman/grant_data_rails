require "spec_helper"
require "time_with_zone_validator"

describe TimeWithZoneValidator do
  class TimeWithZoneValidatorTester
    include ActiveModel::Validations

    attr_reader :attributes, :date
    
    def initialize attributes = {}
      @attributes = attributes
      @date       = attributes[:date]
    end

    validates :date,
      time_with_zone: true
  end

  it "adds no errors when given an ActiveSupport::TimeWithZone" do
    time_with_zone = TimeWithZoneValidatorTester.new date: Time.zone.local(2013, 1, 1)
    expect(time_with_zone).to be_valid
  end

  it "adds an errors when given something other than an ActiveSupport::TimeWithZone" do
    date      = TimeWithZoneValidatorTester.new date: Date.new(2013, 1, 1)
    time      = TimeWithZoneValidatorTester.new date: Time.new(2013, 1, 1)
    date_time = TimeWithZoneValidatorTester.new date: DateTime.new(2013, 1, 1)
    string    = TimeWithZoneValidatorTester.new date: "1/1/2013"
    expect(date).to be_invalid
    expect(time).to be_invalid
    expect(date_time).to be_invalid
    expect(string).to be_invalid
  end
end
