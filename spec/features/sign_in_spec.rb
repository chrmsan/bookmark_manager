feature 'sign in' do
  it 'allows a new user to sign up' do
    visit '/'
    click_button 'Register'
    fill_in 'first_name', with: 'Alan'
    fill_in 'last_name', with: 'Shearer'
    fill_in 'email', with: '@alan.nufc.com'
    fill_in 'password', with: 'NUFC \'til I die'
    expect{ click_button 'Sign up' }.to change{ User.all.count }.by(1)
    expect(page).to have_content 'Welcome, Alan'
  end
end
