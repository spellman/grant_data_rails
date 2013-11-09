require "spec_helper"

describe PatientRecordsPresenter do
  describe "show" do
    before :each do
      @patient = Patient.create name: "name", diagnosis: "diagnosis"
      Time.zone = "Central Time (US & Canada)"
      3.times do |i|
        valid_day = (i % 27) + 1
        date = Time.zone.local(2000, 1, valid_day)
        @patient.records.create bmi:      i,
                                bmi_date: date,
                                a1c:      i,
                                a1c_date: date
      end
      @records    = @patient.records
      @view_model = PatientRecordsPresenter.new(@records).show
    end

    it "creates a hash of record attributes from a collection of records" do
      expect(@view_model).to be_a Hash
    end

    specify "hash keys are title-cased record attribute names" do
      expect(@view_model["Bmi"]).to be_an Array
      expect(@view_model["A1c"]).to be_an Array
    end

    specify "hash values are attribute values of records, sorted by date created" do
      a1cs = @records.order(created_at: :asc).pluck(:a1c)
      expect(@view_model["A1c"]).to eq [a1cs.first, a1cs.second, a1cs.third]
    end

    specify "dates are US Central time, mm/dd/yyyy, months blank-padded, days 0-padded" do
      dates = [" 1/01/2000", " 1/02/2000", " 1/03/2000"]
      expect(@view_model["A1c Date"]).to eq dates
    end
  end
end
