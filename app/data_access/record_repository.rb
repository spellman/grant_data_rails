class RecordRepository

  attr_reader :record_class

  def initialize record_class
    @record_class = record_class
  end

  def save data_hash
    record_class.create data_hash
  end

end
