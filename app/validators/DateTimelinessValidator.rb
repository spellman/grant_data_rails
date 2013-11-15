class DateTimelinessValidator < ActiveModel::EachValidator
  def validate_each record, attribute, value
    unless value.is_a? TimeWithZone
      p record
      p value
      p value.class
      record.errors.add attribute, "must be a valid date"
    end
  end
end
