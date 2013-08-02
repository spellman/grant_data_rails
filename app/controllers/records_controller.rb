require "grant_data/interactors/persist_record_interactor"
require "grant_data_persistence/record_repository"

class RecordsController < ApplicationController

  def new
    @record = Record.new
  end

  def save
    @record = Record.new record_params
    if @record.valid?
      request_model  = build_request_model_from record_params
      repository     = GrantDataPersistence::RecordRepository.new
      response_model = run interactor:    GrantData::PersistRecordInteractor,
                           request_model: request_model,
                           repository:    repository
      view_model = build_view_model_from request_model: request_model,
                                         response_model: response_model
      flash[:success] = "#{view_model[:name]}: #{view_model[:status]}"
      redirect_to root_path and return
    end
    render "new"
  end

  def record_params
    params.require(:record).permit(:name)
  end

  def build_request_model_from form_data
    { name: form_data[:name] }
  end

  def run interactor: nil, request_model: nil, repository: nil
    interactor.new(request_model: request_model, repository: repository).run
  end

  def build_view_model_from request_model: nil, response_model: nil
    { status: "saved", name: request_model[:name] } if response_model[:saved]
  end

end
