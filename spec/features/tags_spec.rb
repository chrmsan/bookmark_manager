feature "creating links with tags" do
  scenario "creates a single tag for a link" do
    visit '/links/new'
    fill_in "title", :with => "Ruby Gems"
    fill_in "url", :with => "https://rubygems.org"
    fill_in "tags", :with => "ruby reference"
    click_button "Add Link"

    link = Link.first
    expect(link.tags.map(&:name)).to include('ruby reference')
  end
end


feature "filter links by tag" do

  before(:each) do
    Link.create(url: 'http://www.abc.com', title: 'ABC', tags: [Tag.first_or_create(name: 'news')])
    Link.create(url: 'http://www.google.com', title: 'Google', tags: [Tag.first_or_create(name: 'search')])
    Link.create(url: 'http://www.sport.com', title: 'Howzatt', tags: [Tag.first_or_create(name: 'cricket')])
    Link.create(url: 'http://www.onedayint.com', title: 'Hit for 6', tags: [Tag.first_or_create(name: 'cricket')])
  end

  scenario "return link which has searched tag" do
    visit '/tags/cricket'

    expect(page.status_code).to eq(200)
    within 'ul#links' do
      expect(page).not_to have_content('ABC')
      expect(page).not_to have_content('Google')
      expect(page).to have_content('Howzatt')
      expect(page).to have_content('Hit for 6')
    end
  end
end

feature 'add multiple tags' do
  scenario 'returns all tags for a link' do
    visit '/links/new'
    fill_in "title", :with => 'Howzatt'
    fill_in "url", :with => 'http://www.sport.com'
    fill_in "tags", :with => 'cricket, news'
    click_button "Add Link"
    expect(Link.first.tags.map(&:name)).to include('cricket', 'news')
  end
end
