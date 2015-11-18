class DateValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless value.is_a?(Date)
      record.errors.add(attribute,
                        "must be a valid date (mm/dd/yyyy or yyyy-mm-dd)")
    end
  end
end
