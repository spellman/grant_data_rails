require "grant_data/interactors/persist_record_interactor"

class RecordsController < ApplicationController

  def new
    @record = Record.new
  end

  def save
    @record = Record.new record_params
    if @record.valid?
      request_model  = build_request_model_from record_params
      repository     = RecordRepository.new Record
      response_model = GrantData::PersistRecordInteractor.new(request_model: request_model,
                                                              repository:    repository).run
      view_model     = RecordsPresenter.new(response_model).new
      flash          = build_flash_from view_model
      redirect_to root_path and return
    end
    render "new"
  end

  # private
  def record_params
    params.require(:record).permit(:name)
  end

  def build_request_model_from form_data
    { name: form_data[:name] }
  end

  def build_flash_from view_model
    flash[:success] = "#{view_model[:name]}: #{view_model[:status]}"
  end

end
