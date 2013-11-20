class TimeWithZoneValidator < ActiveModel::EachValidator
  def validate_each record, attribute, value
    unless value.is_a? ActiveSupport::TimeWithZone
      record.errors.add attribute, "must be a valid date"
    end
  end
end
