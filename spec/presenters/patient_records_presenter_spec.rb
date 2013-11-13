require "spec_helper"

describe PatientRecordsPresenter do
  describe "show" do
    before :each do
      @patient = Patient.create name: "name", diagnosis: "diagnosis"
      Time.zone = "Central Time (US & Canada)"
      3.times do |i|
        valid_day_asc  = (i % 27) + 1
        valid_day_desc = 28 - valid_day_asc
        r = @patient.records.build bmi:      i,
                                   bmi_date: Time.zone.local(2000 + i, 1, valid_day_asc),
                                   a1c:      i,
                                   a1c_date: Time.zone.local(2000 + i, 1, valid_day_desc)
        r.save
      end
      @records    = @patient.records
      @view_model = PatientRecordsPresenter.new(@records).index
    end

    specify "view model contains an array of each record attribute data points" do
      expect(@view_model[:bmi]).to be_an Array
    end

    specify "data points have a date, and optional values" do
      expect(@view_model[:bmi].first[:value]).not_to be_nil
      expect(@view_model[:bmi].first[:date]).not_to be_nil
    end

    specify "data points are sorted by date" do
      actual_bmi_dates   = @view_model[:bmi].map { |bmi| bmi[:date] }
      expected_bmi_dates = @records.order(bmi_date: :asc)
                                   .pluck(:bmi_date)
                                   .map { |date| format_date date }
      actual_a1c_dates   = @view_model[:a1c].map { |a1c| a1c[:date] }
      expected_a1c_dates = @records.order(a1c_date: :asc)
                                   .pluck(:a1c_date)
                                   .map { |date| format_date date }
      expect(actual_bmi_dates).to eq expected_bmi_dates
      expect(actual_a1c_dates).to eq expected_a1c_dates
    end

    specify "nil dates / values are handled" do
      a1c_no_bmi = @patient.records.build(a1c: 5, a1c_date: Time.zone.local(2001, 1, 1))
      a1c_no_bmi.save
      expect(@view_model[:a1c].length).to eq @view_model[:bmi].length
      expect do
        @vm = PatientRecordsPresenter.new(@patient.records).index
      end.not_to raise_error
      expect(@vm[:a1c].length).to be > @vm[:bmi].length
    end

    specify "dates are US Central time, mm/dd/yyyy, months blank-padded, days 0-padded" do
      actual_dates = @view_model[:bmi].map { |bmi| bmi[:date] }
      expect(actual_dates).to eq [" 1/01/2000", " 1/02/2001", " 1/03/2002"]
    end
  end

  def format_date date
    return nil unless date
    date.in_time_zone("Central Time (US & Canada)").strftime("%_m/%d/%Y")
  end
end
