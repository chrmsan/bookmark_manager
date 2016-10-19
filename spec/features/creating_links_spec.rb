require 'spec_helper'

feature 'create new links' do
  scenario 'adding a new link to my Bookmark Manager page' do
  visit '/links/new'
  fill_in 'url', with: 'www.facebook.com'
  fill_in 'title', with: 'Facebook'
  click_button 'Add Link'

  expect(current_path).to eq '/links'

    within 'ul#links' do
      expect(page).to have_content 'Facebook'
    end
  end
end