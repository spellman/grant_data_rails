require "spec_helper"

describe PatientRecordsPresenter do
  describe "Index View Model" do
    before :each do
      @patient = Patient.create name: "name", diagnosis: "diagnosis"
      3.times do |i|
        valid_day_asc  = (i % 27) + 1
        valid_day_desc = 28 - valid_day_asc
        r = Record.new patient_id: @patient.id,
                       a1c: {
                         a1c:  i,
                         date: Time.zone.local(2000 + i, 1, valid_day_asc).to_s,
                       },
                       cholesterol: {
                         tc:   i,
                         tg:   i,
                         hdl:  i,
                         ldl:  i,
                         date: Time.zone.local(2000 + i, 1, valid_day_desc).to_s
                       }
        r.save
      end
      @presenter  = PatientRecordsPresenter.new @patient
      @view_model = @presenter.index
    end

    specify "view model contains an array of each records of each type of model" do
      expect(@view_model[:a1c]).to be_an Array
      expect(@view_model[:cholesterol]).to be_an Array
      expect(@view_model[:bmi]).to be_an Array
    end

    specify "records have a date, and may have values" do
      expect(@view_model[:a1c].first[:a1c]).not_to be_nil
      expect(@view_model[:a1c].first[:date]).not_to be_nil
    end

    specify "each model's records are sorted by date" do
      actual_a1cs        = @view_model[:a1c].map { |o| o[:a1c] }
      actual_chol_tcs    = @view_model[:cholesterol].map { |o| o[:tc] }
      expected_a1cs      = @patient.a1cs
                                   .order(date: :asc)
                                   .pluck(:a1c)
      expected_chol_tcs  = @patient.cholesterols
                                   .order(date: :asc)
                                   .pluck(:tc)
      expect(actual_a1cs).to eq expected_a1cs
      expect(actual_chol_tcs).to eq expected_chol_tcs
    end

    specify "dates are US Central time, mm/dd/yyyy, months blank-padded, days 0-padded" do
      actual_dates = @view_model[:a1c].map { |o| o[:date] }
      expect(actual_dates).to eq ["1/01/2000", "1/02/2001", "1/03/2002"]
    end
  end
end
