class PatientRecordsPresenter
  attr_reader :records

  def initialize records = []
    @records = records
  end

  def index
    data_by_attribute = group_data_by_attribute_from records
    data_hash         = sort_attr_values_by_timestamp_in data_by_attribute
    format_dates_in data_hash
  end

  # private
  def group_data_by_attribute_from records
    merge_record_hashes records.map { |record| build_hash_from record }
  end

  def build_hash_from record
    hash_pairs = record.attributes.map do |name, val|
      [name.titlecase, { record.created_at => val }] unless no_display?(name)
    end.compact
    Hash[hash_pairs]
  end

  def merge_record_hashes record_hashes
    record_hashes.each_with_object({}) do |record_hash, memo|
      memo.merge!(record_hash) { |key, old_val, new_val| old_val.merge new_val }
    end
  end

  def sort_attr_values_by_timestamp_in data_by_attribute
    sorted = data_by_attribute.map do |attribute, timestamp_value_hash|
      sorted = timestamp_value_hash.sort_by { |ts, val| ts }.map(&:last)
      [attribute, sorted]
    end
    Hash[sorted]
  end

  def no_display? attr_name
    ["id", "created_at", "updated_at", "patient_id"].include? attr_name.downcase
  end

  def format_dates_in data_hash
    formated_dates = data_hash.select { |k, v| k =~ /^.*Date$/ }
                              .map do |name, dates|
                                [name, dates.map { |date| format_date date }]
                              end
    data_hash.merge Hash[formated_dates]
  end

  def format_date date
    return nil unless date
    date.in_time_zone("Central Time (US & Canada)").strftime("%_m/%d/%Y")
  end
end
