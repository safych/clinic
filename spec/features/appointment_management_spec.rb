require "rails_helper"

RSpec.describe "Appointment management", :type => :feature do
  before :each do
    create(:patient)
    create(:category)
    @user = create(:doctor)
    create(:appointment)
  end

  it "doctor successfully adds a recommendation for patient" do
    visit "/"

    click_on "Log in"
    click_on "Are you a doctor?"
    
    fill_in "doctor_phone", with: "+380962043239"
    fill_in "doctor_password", with: "123456"
    click_button "Log in"

    click_on "Appointments"
    click_on "Show this appointment"
    click_on "Add recommendation"

    fill_in "recommendation", with: "eojgopejroigjopetrhio"
    click_button "Add recommendation"
    expect(page).to have_text("Appointment was successfully added to the recommendation.")
  end
end
