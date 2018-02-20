require "rails_helper"  

RSpec.feature "Sessions", :type => :feature do  

    before(:each) do
        @user = FactoryGirl.create(:user)
    end

    scenario "invalid login displays one flash message" do  
        # Create user
        @user.password = "bad_password"

        # Open Login page
        visit "login"

        # Fill in form
        fill_in('Email', with: @user.email)
        fill_in('Password', with: @user.password)
        click_button('Log in')

        # Flash 'Invalid...' message
        expect(page).to have_selector ".alert", text: "Invalid email/password combination"

        # Navigate to another page
        visit "/"

        # Flash 'Invalid...' message
        expect(page).to_not have_selector ".alert", text: "Invalid email/password combination"
    end 

    scenario "log in with valid information exposes logout menu option" do
        # Open Login page
        visit "login"

        # Fill in form
        fill_in('Email', with: @user.email)
        fill_in('Password', with: @user.password)

        #Log in
        click_button('Log in')

        # Logout menu option
        expect(page).to have_link("logout")
    end
    
    scenario "log out exposes login menu option" do
        # Open Login page
        visit "login"

        # Fill in form
        fill_in('Email', with: @user.email)
        fill_in('Password', with: @user.password)

        #Log in
        click_button('Log in')

        # Logout
        click_link('logout') 
7
        # Login menu option
        expect(page).to have_link("login")
    end
    
end  

