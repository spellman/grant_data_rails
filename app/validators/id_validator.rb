class IdValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless valid_id?(id_attr: attribute, id: value)
      record.errors.add(attribute, "must be valid")
    end
  end

  # private
  def valid_id?(id_attr: nil, id: nil)
    attr_name = id_attr.to_s.sub(/_id$/, "")
    attr_class = attr_name.humanize.titlecase.gsub("\s", "").constantize
    attr_class.exists?(id)
  end
end
