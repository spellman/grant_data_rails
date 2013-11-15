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
    
    @patient      = Patient.find params[:patient_id]
    @a1cs         = @patient.a1cs.order(:date, :asc)
    @acrs         = @patient.acrs.order(:date, :asc)
    @bmis         = @patient.bmis.order(:date, :asc)
    @cholesterols = @patient.cholesterols.order(:date, :asc)
    @ckd_stages   = @patient.ckd_stages.order(:date, :asc)
    @eye_exams    = @patient.eye_exams.order(:date, :asc)
    @flus         = @patient.flus.order(:date, :asc)
    @foot_exams   = @patient.foot_exams.order(:date, :asc)
    @livers       = @patient.livers.order(:date, :asc)
    @pneumonias   = @patient.pneumonias.order(:date, :asc)
    @renals       = @patient.renals.order(:date, :asc)
    respond_to do |format|
      format.html
      format.csv  { csv_download }
    end
  end

  def create
    @a1c         = A1c.new a1c_params
    @acr         = Acr.new acr_params
    @bmi         = Bmi.new bmi_params
    @cholesterol = Cholesterol.new cholesterol_params
    @ckd_stage   = CkdStage.new ckd_stage_params
    @eye_exam    = EyeExam.new eye_exam_params
    @flu         = Flu.new flu_params
    @foot_exam   = FootExam.new foot_exam_params
    @liver       = Liver.new liver_params
    @pneumonia   = Pneumonia.new pneumonia_params
    @renal       = Renal.new renal_params

    save_models ? save_succeeded : save_failed
  end

  # private
  def a1c_params
    params.require(:a1c).permit(:patient_id,
                                :a1c,
                                :date)
  end

  def acr_params
    params.require(:acr).permit(:patient_id,
                                :acr,
                                :date)
  end

  def bmi_params
    params.require(:bmi).permit(:patient_id,
                                :bmi,
                                :date)
  end

  def cholesterol_params
    params.require(:cholesterol).permit(:patient_id,
                                        :tc,
                                        :tg,
                                        :hdl,
                                        :ldl,
                                        :date)
  end

  def ckd_stage_params
    params.require(:ckd_stage).permit(:patient_id,
                                      :ckd_stage,
                                      :date)
  end

  def eye_exam_params
    params.require(:eye_exam).permit(:patient_id,
                                     :date)
  end

  def flu_params
    params.require(:flu).permit(:patient_id,
                                :date)
  end

  def foot_exam_params
    params.require(:foot_exam).permit(:patient_id,
                                      :date)
  end

  def liver_params
    params.require(:liver).permit(:patient_id,
                                  :ast,
                                  :alt,
                                  :date)
  end

  def pneumonia_params
    params.require(:pneumonia).permit(:patient_id,
                                      :date)
  end

  def renal_params
    params.require(:renal).permit(:patient_id,
                                  :bun,
                                  :creatinine,
                                  :date)
  end

  def save_models
    ActiveRecord::Base.transaction do
      @a1c.save
      @acr.save
      @bmi.save
      @cholesterol.save
      @ckd_stage.save
      @eye_exam.save
      @flu.save
      @foot_exam.save
      @liver.save
      @pneumonia.save
      @renal.save
    end
  end

  def save_succeeded
    redirect_to patient_records_path(params[:patient_id])
  end

  def save_failed
    @patient      = Patient.find params[:patient_id]
    @a1cs         = @patient.a1cs.order(:date, :asc)
    @acrs         = @patient.acrs.order(:date, :asc)
    @bmis         = @patient.bmis.order(:date, :asc)
    @cholesterols = @patient.cholesterols.order(:date, :asc)
    @ckd_stages   = @patient.ckd_stages.order(:date, :asc)
    @eye_exams    = @patient.eye_exams.order(:date, :asc)
    @flus         = @patient.flus.order(:date, :asc)
    @foot_exams   = @patient.foot_exams.order(:date, :asc)
    @livers       = @patient.livers.order(:date, :asc)
    @pneumonias   = @patient.pneumonias.order(:date, :asc)
    @renals       = @patient.renals.order(:date, :asc)
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
