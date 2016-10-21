feature 'sign in' do

  before do
    visit '/'
    click_button 'Register'
    fill_in 'first_name', with: 'Alan'
    fill_in 'last_name', with: 'Shearer'
    fill_in 'email', with: 'alan@nufc.com'
    fill_in 'password', with: '1234'
    fill_in 'password_confirmation', with: '1234'
    click_button 'Sign up'
  end

  it 'allows a registered user to sign in' do
    visit '/'
    click_button 'Sign in'
    fill_in 'email', with: 'alan@nufc.com'
    fill_in 'password', with: '1234'
    click_button 'Sign in'
    expect(current_path).to eq '/links'
    expect(page).to have_content 'Welcome, Alan'
  end
end
