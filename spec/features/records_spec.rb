require "spec_helper"
include UserManagement

feature "patient records page" do
  before :each do
    sign_in_user
    @patient    = Patient.create name: "name", diagnosis: "diagnosis"
    @valid_date = Time.zone.local 2013, 1, 1
  end

  scenario "displays the correct title" do
    visit patient_records_path(@patient.id)
    expect(page).to have_title "Waivers Grant Data | Records"
  end

  scenario "displays the correct heading" do
    visit patient_records_path(@patient.id)
    expect(page).to have_content "Waivers Grant Data"
  end

  scenario "displays the patient's name" do
    visit patient_records_path(@patient.id)
    expect(find("div.patient-records-header")).to have_content @patient.name
  end

  scenario "displays the patient's diagnosis" do
    visit patient_records_path(@patient.id)
    expect(find("div.patient-records-header")).to have_content @patient.diagnosis
  end

  scenario "allows user to add a record" do
    visit patient_records_path(@patient.id)
    expect do
      within "form" do
        fill_in "A1c", with: 101
        fill_in "record_a1c_date", with: @valid_date
        click_button "Save"
      end
    end.to change{ @patient.a1cs.count }.by(1)
    expect(page).to have_content "101"
  end

  scenario "displays errors when user tries to save an invalid record" do
    visit patient_records_path(@patient.id)
    within "form" do
      fill_in "BMI", with: "non-numeric value"
      fill_in "record_bmi_date", with: @valid_date
      click_button "Save"
    end
    expect(all("#error-explanation > ul > li").length).to be > 0
  end

  scenario "displays errors when user tries to save an invalid (blank) record" do
    visit patient_records_path(@patient.id)
    within "form" do
      click_button "Save"
    end
    expect(all("#error-explanation > ul > li").length).to eq 1
  end

  scenario "does not allow saving an invalid record" do
    visit patient_records_path(@patient.id)
    expect { click_button "Save" }.not_to change{ @patient.a1cs.count }
    expect { click_button "Save" }.not_to change{ @patient.acrs.count }
    expect { click_button "Save" }.not_to change{ @patient.bmis.count }
    expect { click_button "Save" }.not_to change{ @patient.cholesterols.count }
    expect { click_button "Save" }.not_to change{ @patient.ckd_stages.count }
    expect { click_button "Save" }.not_to change{ @patient.eye_exams.count }
    expect { click_button "Save" }.not_to change{ @patient.flus.count }
    expect { click_button "Save" }.not_to change{ @patient.foot_exams.count }
    expect { click_button "Save" }.not_to change{ @patient.livers.count }
    expect { click_button "Save" }.not_to change{ @patient.pneumonias.count }
    expect { click_button "Save" }.not_to change{ @patient.renals.count }
  end

  after :each do
    sign_out
  end
end
