require "csv"

class Record < ActiveRecord::Base
  validates_presence_of :name

  def self.to_csv
    CSV.generate do |csv|
      csv << column_names
      all.each do |record|
        csv << record.attributes.values_at(*column_names)
      end
    end
  end

end
