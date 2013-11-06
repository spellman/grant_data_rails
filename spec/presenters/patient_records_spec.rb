require "spec_helper"

describe PatientRecordsPresenter do
  describe "show" do
    before :each do
      3.times { |i| Record.create name: "foo", diagnosis: "bar", a1c: i }
      @records   = Record.where "name = ?", "foo"
      presenter = PatientRecordsPresenter.new @records
      @view_model = presenter.show
    end

    it "creates a hash of record attributes from a collection of records" do
      expect(@view_model).to be_a Hash
    end

    specify "hash keys are record title-cased attribute names" do
      expect(@view_model["Name"]).to be_an Array
      expect(@view_model["A1c"]).to be_an Array
    end

    specify "hash values are arrays of attribute values from the given records, sorted by timestamp" do
      a1cs = @records.order(created_at: :asc).pluck(:a1c)
      expect(@view_model["A1c"]).to eq [a1cs.first, a1cs.second, a1cs.third]
    end
  end
end
