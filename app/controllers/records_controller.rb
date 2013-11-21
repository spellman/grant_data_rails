require "patient_records_presenter"

class RecordsController < ApplicationController
  def index
    @record     = Record.new
    @patient    = Patient.find params[:patient_id]
    @view_model = PatientRecordsPresenter.new(@patient).index
    respond_to do |format|
      format.html
      format.csv  { csv_download }
    end
  end

  def create
    @record = Record.new record_params
    if @record.save
      redirect_to patient_records_path(params[:patient_id])
    else
      @patient    = Patient.find params[:patient_id]
      @view_model = PatientRecordsPresenter.new(@patient).index
      render "index"
    end
  end

  # private
  def record_params
    params.require(:record).permit(:patient_id,
                                   a1c:         [:a1c, :date],
                                   acr:         [:acr, :date],
                                   bmi:         [:bmi, :date],
                                   cholesterol: [:tc, :tg, :hdl, :ldl, :date],
                                   ckd_stage:   [:ckd_stage, :date],
                                   eye_exam:    [:date],
                                   flu:         [:date],
                                   foot_exam:   [:date],
                                   liver:       [:ast, :alt, :date],
                                   pneumonia:   [:date],
                                   renal:       [:bun, :creatinine, :date])
  end

  def csv_download
#    send_data @patient.records.to_csv, filename: csv_filename, type: "text/csv"
  end

  def csv_filename
    "records-#{DateTime.now.to_s}"
  end
end
