require "rails_helper"

RSpec.describe "Appointment management", :type => :request do
  before :each do
    @user = create(:patient)
    sign_in @user
  end

  after :each do
    sign_out @user
  end

  it "returns status found" do
    headers = { "ACCEPT" => "application/json" }
    post "/appointments", :params => { appointment: { doctor_id: "1", patient_id: @user.id, status: "wait", 
                                                      date: "2022-12-11" } }, :headers => headers

    expect(response.content_type).to eq("text/html; charset=utf-8")
    expect(response).to have_http_status(:found)
  end
end