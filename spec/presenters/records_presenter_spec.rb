require File.expand_path(File.join(File.dirname(__FILE__), "..", "no_rails_helper"))
require "presenters/records_presenter"

describe RecordsPresenter do

  it "builds the view model for the new record page" do
    response_model = { record: { name: "foo" } }
    view_model     = {
                       status: "saved",
                       name:   "foo"
                     }
    presenter      = RecordsPresenter.new response_model
    expect(presenter.new).to eq view_model
  end

end
