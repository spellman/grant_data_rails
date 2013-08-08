require File.expand_path(File.join(File.dirname(__FILE__), "..", "no_rails_helper"))
require "data_access/record_repository"

describe RecordRepository do

  it "confirms successfully saving a record" do
    record_data = { name: "foo" }
    active_record_record = double "ActiveRecord Record class"
    repository = RecordRepository.new active_record_record
    expect(active_record_record).to receive(:create).with(record_data)
    repository.save record_data
  end

end
