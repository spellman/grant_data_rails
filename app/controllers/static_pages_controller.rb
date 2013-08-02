require "grant_data/interactors/persist_record_interactor"
require "grant_data_persistence/record_repository"

class StaticPagesController < ApplicationController

  def index
#    @record = Record.new
  end

  def save_record
    record = Record.new params
    if record.valid?
      request_model = build_request_model_from params
      repository = GrantDataPersistence::RecordRepository.new
      response_model = run interactor:    GrantData::PersistRecordInteractor,
                           request_model: request_model,
                           repository:    repository
      build_view_model_from request_model: request_model,
                            response_model: response_model
    end
    render "index"
  end

  def build_request_model_from form_data
    { name: form_data[:name] }
  end

  def run interactor: nil, request_model: nil, repository: nil
    interactor.new(request_model: request_model, repository: repository).run
  end

  def build_view_model_from request_model: nil, response_model: nil
    @view_model = if response_model[:saved]
                    { status: "saved", name: request_model[:name] }
                  end
  end

end
