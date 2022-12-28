require 'rails_helper'

RSpec.describe Doctor, type: :model do
  context "returns an empty array" do
    it "returns anything" do
      doctor = Doctor.new
      doctor.phone = "+380985520021"
      doctor.validate
      expect(doctor.errors[:phone]).to eq []
    end

    it "returns incorrectly entered phone number" do
      doctor = Doctor.new
      doctor.phone = "+38098552001"
      doctor.validate
      expect(doctor.errors[:phone]).to include("Incorrectly entered phone number")
    end
  end
end
