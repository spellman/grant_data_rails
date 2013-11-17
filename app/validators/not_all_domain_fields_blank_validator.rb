class NotAllDomainFieldsBlankValidator < ActiveModel::Validator
  attr_reader :domain_fields

  def initialize params
    super
    @domain_fields = params[:domain_fields] || []
  end

  def validate record
    if all_domain_fields_blank? record
      record.errors.add :base, error_message
    end
  end

  # private
  def all_domain_fields_blank? record
    record.attributes.reject { |k, v| !(domain_fields.include?(k)) || v.blank? }.empty?
  end

  def error_message
    "At least one of #{domain_fields.join(", ")} cannot be blank"
  end
end
