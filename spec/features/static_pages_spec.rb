require "spec_helper"

feature "Home page" do
  scenario "loads properly" do
    visit static_pages_index_path
    expect(page.status_code).to eq 200
  end
end
