class RecordsController < ApplicationController
  def index
    @a1c         = A1c.new
    @acr         = Acr.new
    @bmi         = Bmi.new
    @cholesterol = Cholesterol.new
    @ckd_stage   = CkdStage.new
    @eye_exam    = EyeExam.new
    @flu         = Flu.new
    @foot_exam   = FootExam.new
    @liver       = Liver.new
    @pneumonia   = Pneumonia.new
    @renal       = Renal.new
    @error_aggregator = ErrorAggregator.new
    
    @patient      = Patient.find params[:patient_id]
    @a1cs         = @patient.a1cs.order(date: :asc)
    @acrs         = @patient.acrs.order(date: :asc)
    @bmis         = @patient.bmis.order(date: :asc)
    @cholesterols = @patient.cholesterols.order(date: :asc)
    @ckd_stages   = @patient.ckd_stages.order(date: :asc)
    @eye_exams    = @patient.eye_exams.order(date: :asc)
    @flus         = @patient.flus.order(date: :asc)
    @foot_exams   = @patient.foot_exams.order(date: :asc)
    @livers       = @patient.livers.order(date: :asc)
    @pneumonias   = @patient.pneumonias.order(date: :asc)
    @renals       = @patient.renals.order(date: :asc)
    respond_to do |format|
      format.html
      format.csv  { csv_download }
    end
  end

  def create
    @patient     = Patient.find params[:patient_id]
    @models_to_save = []
    @models_to_save << @a1c         = A1c.new(a1c_params)
    @models_to_save << @acr         = Acr.new(acr_params)
    @models_to_save << @bmi         = Bmi.new(bmi_params)
    @models_to_save << @cholesterol = Cholesterol.new(cholesterol_params)
    @models_to_save << @ckd_stage   = CkdStage.new(ckd_stage_params)
    @models_to_save << @eye_exam    = EyeExam.new(eye_exam_params)
    @models_to_save << @flu         = Flu.new(flu_params)
    @models_to_save << @foot_exam   = FootExam.new(foot_exam_params)
    @models_to_save << @liver       = Liver.new(liver_params)
    @models_to_save << @pneumonia   = Pneumonia.new(pneumonia_params)
    @models_to_save << @renal       = Renal.new(renal_params)

    if all_models_blank?
      ea = ErrorAggregator.new
      ea.errors.full_messages << "Please enter some patient data."
      return save_failed ea
    end

    begin
      save_models!
      save_succeeded
    rescue ActiveRecord::RecordInvalid
      save_failed ErrorAggregator.new(@models_to_save)
    end
  end

  # private
  def a1c_params
    params.require(:a1c).permit(:a1c,
                                :date)
  end

  def acr_params
    params.require(:acr).permit(:acr,
                                :date)
  end

  def bmi_params
    params.require(:bmi).permit(:bmi,
                                :date)
  end

  def cholesterol_params
    params.require(:cholesterol).permit(:tc,
                                        :tg,
                                        :hdl,
                                        :ldl,
                                        :date)
  end

  def ckd_stage_params
    params.require(:ckd_stage).permit(:ckd_stage,
                                      :date)
  end

  def eye_exam_params
    params.require(:eye_exam).permit(:date)
  end

  def flu_params
    params.require(:flu).permit(:date)
  end

  def foot_exam_params
    params.require(:foot_exam).permit(:date)
  end

  def liver_params
    params.require(:liver).permit(:ast,
                                  :alt,
                                  :date)
  end

  def pneumonia_params
    params.require(:pneumonia).permit(:date)
  end

  def renal_params
    params.require(:renal).permit(:bun,
                                  :creatinine,
                                  :date)
  end

  def save_models!
    ActiveRecord::Base.transaction do
      @models_to_save.each do |model|
        unless all_fields_blank_in? model
          model.patient_id = @patient.id
          model.save!
        end
      end
    end
  end

  def all_models_blank?
    @models_to_save.all? { |model| all_fields_blank_in? model }
  end

  def all_fields_blank_in? model
    model.attributes.all? { |k, v| v.blank? }
  end

  def save_succeeded
    redirect_to patient_records_path(params[:patient_id])
  end

  def save_failed error_aggregator
    @a1cs         = @patient.a1cs.order(date: :asc)
    @acrs         = @patient.acrs.order(date: :asc)
    @bmis         = @patient.bmis.order(date: :asc)
    @cholesterols = @patient.cholesterols.order(date: :asc)
    @ckd_stages   = @patient.ckd_stages.order(date: :asc)
    @eye_exams    = @patient.eye_exams.order(date: :asc)
    @flus         = @patient.flus.order(date: :asc)
    @foot_exams   = @patient.foot_exams.order(date: :asc)
    @livers       = @patient.livers.order(date: :asc)
    @pneumonias   = @patient.pneumonias.order(date: :asc)
    @renals       = @patient.renals.order(date: :asc)

    @error_aggregator = error_aggregator
    render "index"
  end

  def delete_failed
    flash[:warning] = "Record to be deleted did not exist. The browser's \"back\" button may have been used to display a record that had already been deleted."
  end

  def paginate_records
    @records = Record.page(params[:page]).per(13).order("created_at DESC")
  end

  def csv_download
    send_data @patient.records.to_csv, filename: csv_filename, type: "text/csv"
  end

  def csv_filename
    "records-#{DateTime.now.to_s}"
  end
end

require "forwardable"

class ErrorAggregatorErrors
  extend Forwardable
  attr_reader :full_messages
  def_delegators :full_messages, :any?, :count

  def initialize
    @full_messages = []
  end
end

class ErrorAggregator
  attr_reader :errors
  def initialize models = []
    @errors = ErrorAggregatorErrors.new
    models.each do |model|
      errors.full_messages.concat model.errors.full_messages
    end
  end
end
