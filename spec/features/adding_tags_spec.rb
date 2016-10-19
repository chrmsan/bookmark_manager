require 'spec_helper'

feature 'Adding tags' do
  scenario 'add a tag to a link' do
    visit '/links/new'
    fill_in 'url', with: 'www.facebook.com'
    fill_in 'title', with: 'Facebook'
    fill_in 'tags', with: 'social'
    click_button 'Add Link'

    link = Link.get(1)
    expect(link.tags.map(&:name)).to include('social')
  end

  scenario 'Adding multiple tags' do
    visit '/links/new'
    fill_in 'url', with: 'www.facebook.com'
    fill_in 'title', with: 'Facebook'
    fill_in 'tags', with: 'social networking'
    click_button 'Add Link'

    link = Link.first
    expect(link.tags.map(&:name)).to include('social', 'networking')
  end
end
