require 'spec_helper'

feature 'User sign up' do
  scenario 'I can sign up as a new user' do
    expect { sign_up }.to change(User, :count).by(1)
    expect(page).to have_content('Welcome, alice@example.com')
    expect(User.first.email).to eq('alice@example.com')
  end

  scenario 'with a password that does not match' do
    expect { sign_up(password_confirmation: 'wrong') }.not_to change(User, :count)
    expect(current_path).to eq('/users')
    expect(page).to have_content 'Password and confirmation password do not match'
  end

  scenario "I can't sign up without an email address" do
    expect { sign_up(email: nil) }.not_to change(User, :count)
  end

  scenario "can't sign up without valid email" do
    expect { sign_up(email: "no-way@email")}.not_to change(User, :count)
  end

  scenario "can't use an existing user's email" do
    sign_up
    expect {sign_up}.not_to change(User, :count)
  end

  scenario "error message if uses existing email" do
    2.times { sign_up }
    expect(page).to have_content 'That email is already registered'
  end

end
