require 'spec_helper'

feature 'filter links' do
  before(:each) do 
    Link.create(url: 'http://www.google.com', title: 'Google', tags: [Tag.first_or_create(name: 'Search Engine')])
    Link.create(url: 'http://www.pokemon.com/no/', title: 'Pokemon', tags: [Tag.first_or_create(name: 'bubbles')])
    Link.create(url: 'www.makersacademy.con', title: 'Makers Academy', tags: [Tag.first_or_create(name: 'Makers Academy')])
    Link.create(url: 'https://no.wikipedia.org/wiki/Digimon', title: 'Digimon', tags: [Tag.first_or_create(name: 'bubbles')])
  end 

  scenario 'filter links by tags' do
    visit '/tags/bubbles'
    expect(page.status_code).to eq 200
      within 'ul#links' do
        expect(page).to have_content('Pokemon')
        expect(page).not_to have_content 'Makers Academy'
        expect(page).to have_content('Digimon')
        expect(page).not_to have_content 'Google'
    end
  end
end