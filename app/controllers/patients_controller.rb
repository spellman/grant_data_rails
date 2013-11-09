class PatientsController < ApplicationController
  def index
    @patient = Patient.new
     patient_search? ? paginate_search_results : paginate_patients
  end

  def show
    @patient = Patient.find params[:id]
    paginate_patients
  end

  def update
    @patient = Patient.find params[:id]
    @patient.update_attributes(patient_params) ? save_succeeded : render("show")
  end

  def destroy
    begin
      patient = Patient.find params[:id]
      patient.records.destroy
      patient.destroy
    rescue ActiveRecord::RecordNotFound
      delete_failed
    end
    redirect_to :patients
  end

  # private
  def patient_params
    params.require(:patient).permit(:name,
                                    :diagnosis)
  end

  def patient_search?
    !!(params[:search])
  end

  def save_succeeded
    redirect_to patients_path
  end

  def delete_failed
    flash[:warning] = "Patient to be deleted did not exist. The browser's \"back\" button may have been used to display a record that had already been deleted."
  end

  def paginate_search_results
    name = params[:search]["name"]
    @patients = Patient.where(name: name).page(params[:page])
                                         .per(13)
                                         .order("name ASC")
  end

  def paginate_patients
    @patients = Patient.page(params[:page])
                       .per(13)
                       .order("name ASC")
  end
end
