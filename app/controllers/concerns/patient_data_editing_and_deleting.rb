module PatientDataEditingAndDeleting
  extend ActiveSupport::Concern

  # The including controller should:
  # 1. Define a model method that returns the model class.
  #    Example:
  #      def model_name
  #        CkdStage
  #      end
  #
  # 2. Define a display_name method that returns a human-readable string,
  #    naming the model instance.
  #    NOTE: THIS IS PROBABLY UNECESSARY BUT I DIDN'T OBSERVE SOME NAMING
  #          CONVENTIONS WHEN I NAMED MY MODELS.
  #          E.G., I USED CkdStage INSTEAD OF CKDStage.
  #    Example:
  #      def display_name
  #        "CKD stage"
  #      end
  #
  # 3. Define a data_params method that whitelists params keys.
  #    Example:
  #      def data_params
  #        params.require(:ckd_stage).permit(
  #          :date
  #        )
  #      end

  def edit
    @data_point = model.find(params[:id])
    respond_to do |format|
      format.html {
        @patient = Patient.find(@data_point.patient_id)
        render_edit
      }
      format.js { render_edit }
    end
  end

  def update
    @data_point = model.find(params[:id])
    if @data_point.update_attributes(data_params)
      redirect_to(patient_records_path(@data_point.patient_id))
    else
      @patient = Patient.find(@data_point.patient_id)
      render_edit
    end
  end

  def destroy
    begin
      data_point = model.find(params[:id])
      data_point.destroy
      redirect_to(patient_records_path(data_point.patient_id))
    rescue ActiveRecord::RecordNotFound
      flash[:warning] = "The record to be deleted did not exist. (Using the browser's back button can cause data to be displayed that no longer exists in the system.)"
      redirect_to(patients_path)
    end
  end

  private
  def render_edit
    render(partial: "shared/edit_data_point",
           locals: {display_name: model.display_name,
                    model_name: model.model_name})
  end

  def record_not_found
    record = display_name
    flash[:warning] = "The requested #{record} could not be found. Has it been deleted? (Another user may have deleted it or the browser's \"back\" button may have been used to display #{prepend_indefinite_article(record)} that had already been deleted.)"
    redirect_to patients_path
  end

  def prepend_indefinite_article(word,
                                 consonant_article = "a",
                                 vowel_article = "an")
    result = word.to_s.dup
    if result.match(/^([aeiou])/i)
      "#{vowel_article} #{result}"
    else
      "#{consonant_article} #{result}"
    end
  end
end
