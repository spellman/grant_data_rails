require "patient_records_presenter"

class RecordsController < ApplicationController
  def index
    @record = Record.new
    respond_to do |format|
      format.html {
        @patient = Patient.find params[:patient_id]
        @view_model = PatientRecordsPresenter.new(@patient).index
      }
      format.js
    end
  end

  def create
    @record = Record.new record_params
    if @record.save
      redirect_to patient_records_path(params[:patient_id])
    else
      @patient = Patient.find params[:patient_id]
      @view_model = PatientRecordsPresenter.new(@patient).index
      render "index"
    end
  end

  # private
  def record_params
    params.require(:record).permit(
      :patient_id,
      a1c: [
        :a1c,
        :date
      ],
      acr: [
        :acr_in_mcg_alb_per_mg_cr,
        :date
      ],
      blood_pressure: [
        :systolic_in_mmhg,
        :diastolic_in_mmhg,
        :date
      ],
      bun_and_creatinine: [
        :bun_in_mg_per_dl,
        :creatinine_in_mg_per_dl,
        :date
      ],
      cholesterol: [
        :ldl_in_mg_per_dl,
        :date
      ],
      ckd_stage: [
        :ckd_stage,
        :date
      ],
      eye_exam: [
        :date
      ],
      foot_exam: [
        :date
      ],
      measurements: [
        :weight_in_pounds,
        :height_in_inches,
        :waist_circumference_in_inches,
        :date
      ],
      testosterone: [
        :testosterone_in_ng_per_dl,
        :date
      ]
    )
  end
end
