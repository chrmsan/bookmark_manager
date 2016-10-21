feature 'sign in' do

  before do
    visit '/'
    click_button 'Register'
    fill_in 'first_name', with: 'Alan'
    fill_in 'last_name', with: 'Shearer'

  end
  it 'allows a new user to sign up' do
    fill_in 'email', with: 'alan@nufc.com'
    fill_in 'password', with: '1234'
    fill_in 'password_confirmation', with: '1234'
    expect{ click_button 'Sign up' }.to change{ User.all.count }.by(1)
    expect(page).to have_content 'Welcome, Alan'
    expect(User.first.email).to eq('alan@nufc.com')
  end

  it 'does not allow an account to be created if the specified passwords do not match' do
    fill_in 'email', with: 'alan@nufc.com'
    fill_in 'password', with: '1234'
    fill_in 'password_confirmation', with: '123'
    expect{ click_button 'Sign up' }.to change{ User.all.count }.by(0)
    expect(current_path).to eq '/users/authenticate'
    expect(page).to have_content 'Password and confirmation password do not match'
  end

  it 'does not allow the user to sign in without entering something in the email field' do
    fill_in 'email', with: nil
    fill_in 'password', with: '1234'
    fill_in 'password', with: '1234'
    click_button 'Sign up'
    expect{ click_button 'Sign up' }.to change{ User.all.count }.by(0)
  end
end
