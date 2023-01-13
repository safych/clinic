require 'rails_helper'

RSpec.describe DoctorsListQuery, type: :feature do
  before :each do
    create(:category)
    create(:category, id: '2', title: 'Oculist')
    create(:doctor)
    create(:doctor, id: '2', category_id: '2', phone: '+380962043238', name: 'Alex', surname: 'Brooks')
  end

  it 'Display of doctors by surname' do
    visit '/'

    click_on 'Doctors'
    expect(page).to have_text('Alex Brooks Oculist +380962043238')
    fill_in 'search_surname', with: 'Morgan'
    click_button 'Search by surname'
    expect(page).to_not have_text('Alex Brooks Oculist +380962043238')
    expect(page).to have_text('Andriy Morgan Psychiatrist +380962043239')
  end

  it 'Display of doctors by category' do
    visit '/'

    click_on 'Doctors'
    expect(page).to have_text('Andriy Morgan Psychiatrist +380962043239')
    select 'Oculist', from: 'search_category'
    click_button 'Search by category'
    expect(page).to_not have_text('Andriy Morgan Psychiatrist +380962043239')
    expect(page).to have_text('Alex Brooks Oculist +380962043238')
  end
end
