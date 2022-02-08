require 'rails_helper'

RSpec.feature "UserLogins", type: :feature, js:true do

  before :each do
    @user = User.create! first_name: 'Peppa',last_name:'Pig', email:'peppa@gmail.com',password:'12345'
  end
  scenario "Users can login and are taken to home page after login" do
    #ACT
    visit '/login'
    fill_in 'email', with: 'peppa@gmail.com'
    fill_in 'password', with: '12345'
    click_on 'Submit'

    # DEBUG / VERIFY
    expect(page).to have_content('Products')
    expect(page).to have_content('Signed in as Pig')
    save_screenshot
  end

end
