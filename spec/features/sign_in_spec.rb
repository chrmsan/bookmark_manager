feature 'sign in' do

  before do
    visit '/'
    click_button 'Register'
    fill_in 'first_name', with: 'Alan'
    fill_in 'last_name', with: 'Shearer'
    fill_in 'email', with: 'alan@nufc.com'
    fill_in 'password', with: '1234'
  end
  it 'allows a new user to sign up' do
    fill_in 'password_confirmation', with: '1234'
    expect{ click_button 'Sign up' }.to change{ User.all.count }.by(1)
    expect(page).to have_content 'WELCOME, Alan'
    expect(User.first.email).to eq('alan@nufc.com')
  end

  it 'informs the user if they have not enetered two identical passwords' do
    fill_in 'password_confirmation', with: '123'
    # expect{ click_button 'Sign up' }.to raise_error 'The passwords entered do not match'
    expect{ click_button 'Sign up' }.to change{ User.all.count }.by(0)
  end
end
