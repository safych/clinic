require "rails_helper"

RSpec.describe "Appointment management", :type => :request do
  before :each do
    @user = create(:patient)
    sign_in @user
  end

  after :each do
    sign_out @user
  end

  it "creates a Appointment" do
    headers = { "ACCEPT" => "application/json" }
    post "/appointments", :params => { appointment: { doctor_id: "1", patient_id: @user.id, status: "wait", 
                                                      date: "2022-12-11" } }, :headers => headers

    expect(response.content_type).to eq("application/json; charset=utf-8")
    expect(response).to have_http_status(:created)   
  end
end