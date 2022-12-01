require 'rails_helper'

RSpec.describe Doctor, type: :model do
  context "Phone number validation check" do
    it "Successful verification" do
      doctor = Doctor.new
      doctor.phone = "+380985520021"
      doctor.validate
      expect(doctor.errors[:phone]).to_not include("Incorrectly entered phone number")
    end

    it "Error verification" do
      doctor = Doctor.new
      doctor.phone = "+38098552001"
      doctor.validate
      expect(doctor.errors[:phone]).to include("Incorrectly entered phone number")
    end
  end
end
