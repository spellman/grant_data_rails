class RecordsController < ApplicationController

  def index
    @record  = Record.new
    @records = Record.all
    respond_to do |format|
      format.html { paginate_records }
      format.csv  { csv_download }
    end
  end

  def create
    @record = Record.new record_params.merge({ created_by: current_user.email })
    @record.save ? save_succeeded : save_failed
  end

  def show
    @record  = Record.find params[:id]
    paginate_records
  end

  def update
    @record = Record.find params[:id]
    @record.update_attributes(record_params) ? save_succeeded : render("show")
  end

  def destroy
    begin
      Record.find(params[:id]).destroy
    rescue ActiveRecord::RecordNotFound
      delete_failed
    end
    redirect_to :records
  end

  # private
  def record_params
    params.require(:record).permit(:name)
  end

  def save_succeeded
    redirect_to :records
  end

  def save_failed
    paginate_records
    render "index"
  end

  def delete_failed
    flash[:warning] = "Record to be deleted did not exist. The browser's \"back\" button may have been used to display a record that had already been deleted."
  end

  def paginate_records
    @records = Record.page(params[:page]).per(13).order("created_at DESC")
  end

  def csv_download
    send_data @records.to_csv, filename: csv_filename, type: "text/csv"
  end

  def csv_filename
    "records-#{DateTime.now.to_s}"
  end

end
