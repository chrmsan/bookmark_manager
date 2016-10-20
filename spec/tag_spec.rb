require 'spec_helper'

feature 'Adding tags' do
  scenario 'adding tags' do
    visit '/links/new'
    fill_in('title', with: "Facebook")
    fill_in('url', with: "www.facebook.com")
    fill_in('tag', with: "social")
    click_button('Save')

    link = Link.first

    expect(link.tags.map(&:name)).to include('social')

  end
end

feature 'Adding multiple tags' do
  scenario " I can add several tags" do
    visit '/links/new'
    fill_in('title', with: "Facebook")
    fill_in('url', with: "www.facebook.com")
    fill_in('tag', with: "social friends")
    click_button('Save')

    link = Link.first

    expect(link.tags.map(&:name)).to include('social', 'friends')

  end
end
