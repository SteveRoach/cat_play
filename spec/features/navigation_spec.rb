require "rails_helper"  
 
RSpec.feature "Site navigation", :type => :feature do  
    scenario "'Home' navigation goes to the Home page" do  
        visit "/" 
        click_link('Cat Play') 
        expect(page).to have_content('A ship in harbour is safe') 
    end 
 
    scenario "'About' navigation goes to the About page" do  
        visit "/" 
        click_link('about') 
        expect(page).to have_content('After years of enjoying Red October, ') 
    end 
 
    scenario "'Contact' navigation goes to the Contact page" do  
        visit "/" 
        click_link('contact') 
        expect(page).to have_content('Send us a message') 
    end 
 
    scenario "'Journal' navigation goes to the Journal page" do  
        visit "/" 
        click_link('Journal') 
        expect(page).to have_content('This is the Journal page.') 
    end 
 
    scenario "'Technical' navigation goes to the Technical page" do  
        visit "/" 
        click_link('Technical') 
        expect(page).to have_content('This is the Technical page.') 
    end 
 
    scenario "'Crew' navigation goes to the Crew page" do  
        visit "/" 
        click_link('Crew') 
        expect(page).to have_content('StaticPages#crew') 
    end 
 
    scenario "'Gallery' navigation goes to the Gallery page" do  
        visit "/" 
        click_link('Gallery') 
        expect(page).to have_content('StaticPages#gallery') 
    end 
 
end  
