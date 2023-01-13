require 'rails_helper'

RSpec.describe AppointmentsListQuery, type: :feature do
  describe 'Appointments patient sort check' do
    before :each do
      create(:category)
      create(:doctor)
      @user = create(:patient)
      create(:appointment)
      create(:appointment, id: '2', doctor_id: '1', patient_id: '1', status: 'done', date: '2023-01-05')
    end

    it 'Display of appointments patient by date' do
      visit '/'

      click_on 'Log in'

      fill_in 'patient_phone', with: '+380931232319'
      fill_in 'patient_password', with: '1234567'
      click_button 'Log in'

      click_on 'Appointments Patient'
      expect(page).to have_text('Morgan Andriy - Psychiatrist done 2023-01-05 Show this appointment')

      page.select '2022', from: '_search_date_1i'
      page.select 'December', from: '_search_date_2i'
      page.select '12', from: '_search_date_3i'
      click_button 'Search by date'
      expect(page).to_not have_text('Morgan Andriy - Psychiatrist done 2023-01-05 Show this appointment')
      expect(page).to have_text('Morgan Andriy - Psychiatrist wait 2022-12-12 Show this appointment')
    end

    it 'Display of appointments patient by status' do
      visit '/'

      click_on 'Log in'

      fill_in 'patient_phone', with: '+380931232319'
      fill_in 'patient_password', with: '1234567'
      click_button 'Log in'

      click_on 'Appointments Patient'
      expect(page).to have_text('Morgan Andriy - Psychiatrist done 2023-01-05 Show this appointment')

      page.choose('search_status_wait')
      click_button 'Search by status'
      expect(page).to_not have_text('Morgan Andriy - Psychiatrist done 2023-01-05 Show this appointment')
      expect(page).to have_text('Morgan Andriy - Psychiatrist wait 2022-12-12 Show this appointment')
    end
  end

  describe 'Appointments doctor sort check' do
    before :each do
      create(:category)
      @user = create(:doctor)
      create(:patient)
      create(:patient, id: '2', phone: '+380962043238', name: 'Alex', surname: 'Brooks')
      create(:appointment)
      create(:appointment, id: '2', doctor_id: '1', patient_id: '2', status: 'done', date: '2023-01-05')
    end

    it 'Display of appointments doctor by date' do
      visit '/'

      click_on 'Log in'
      click_on 'Are you a doctor?'

      fill_in 'doctor_phone', with: '+380962043239'
      fill_in 'doctor_password', with: '123456'
      click_button 'Log in'

      click_on 'Appointments'
      expect(page).to have_text('Brooks Alex +380962043238 done 2023-01-05 Show this appointment')

      page.select '2022', from: '_search_date_1i'
      page.select 'December', from: '_search_date_2i'
      page.select '12', from: '_search_date_3i'
      click_button 'Search by date'
      expect(page).to_not have_text('Brooks Alex +380962043238 done 2023-01-05 Show this appointment')
      expect(page).to have_text('Clooney Bob +380931232319 wait 2022-12-12 Show this appointment')
    end

    it 'Display of appointments doctor by status' do
      visit '/'

      click_on 'Log in'
      click_on 'Are you a doctor?'

      fill_in 'doctor_phone', with: '+380962043239'
      fill_in 'doctor_password', with: '123456'
      click_button 'Log in'

      click_on 'Appointments'
      expect(page).to have_text('Brooks Alex +380962043238 done 2023-01-05 Show this appointment')

      page.choose('search_status_wait')
      click_button 'Search by status'
      expect(page).to_not have_text('Brooks Alex +380962043238 done 2023-01-05 Show this appointment')
      expect(page).to have_text('Clooney Bob +380931232319 wait 2022-12-12 Show this appointment')
    end
  end
end
