class MeasurementsController < ApplicationController
  def edit
    @measurements = Measurements.find(params[:id])
    respond_to do |format| 
      format.html {
        @patient = Patient.find(@measurements.patient_id)
        @view_model = PatientRecordsPresenter.new(@patient).index
      }
      format.js
    end
  end

  def update
    @measurements = Measurements.find(params[:id])
    if @measurements.update_attributes(measurements_params)
      redirect_to patient_records_path(@measurements.patient_id)
    else
      @patient = Patient.find(@measurements.patient_id)
      @view_model = PatientRecordsPresenter.new(@patient).index
      render "edit"
    end
  end

  def destroy
    begin
      measurements = Measurements.find(params[:id])
      measurements.destroy
    rescue ActiveRecord::RecordNotFound
      flash[:warning] = "The patient to be deleted did not exist. The browser's \"back\" button may have been used to display a patient that had already been deleted."
    end
    redirect_to patient_records_path(measurements.patient_id)
  end

  def measurements_params
    params.require(:measurements).permit(
      :height_in_inches,
      :waist_circumference_in_inches,
      :weight_in_pounds,
      :date
    )
  end
end
