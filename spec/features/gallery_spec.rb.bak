require "rails_helper"  
 
RSpec.feature "Gallery Pages", :type => :feature do  
    scenario "displays the Boat page elements correctly" do  
        visit "gallery_boat" 
 
        # Page title 
        expect(page).to have_title('Cat Play | Boat Gallery')  
 
        # Favicon
        icon_link_count = page.all(:css, 'link[rel~="icon"]', visible: false).count 
        expect(icon_link_count).to eql(1)  
 
        page.all(:css, 'link[rel~="icon"]', visible: false).each do |fav|  
            visit fav[:href]  
            expect(page).to have_http_status(:success)  
        end  
    end 
 
    scenario "displays the Crew page elements correctly" do  
        visit "gallery_crew" 
 
        # Page title 
        expect(page).to have_title('Cat Play | Crew Gallery')  
 
        # Favicon
        icon_link_count = page.all(:css, 'link[rel~="icon"]', visible: false).count 
        expect(icon_link_count).to eql(1)  
 
        page.all(:css, 'link[rel~="icon"]', visible: false).each do |fav|  
            visit fav[:href]  
            expect(page).to have_http_status(:success)  
        end  
    end 
 
    scenario "displays the Cats page elements correctly" do  
        visit "gallery_cats" 
 
        # Page title 
        expect(page).to have_title('Cat Play | Cats Gallery')  
 
        # Favicon
        icon_link_count = page.all(:css, 'link[rel~="icon"]', visible: false).count 
        expect(icon_link_count).to eql(1)  
 
        page.all(:css, 'link[rel~="icon"]', visible: false).each do |fav|  
            visit fav[:href]  
            expect(page).to have_http_status(:success)  
        end  
    end 
 
    scenario "displays the People page elements correctly" do  
        visit "gallery_people" 
 
        # Page title 
        expect(page).to have_title('Cat Play | People Gallery')  
 
        # Favicon
        icon_link_count = page.all(:css, 'link[rel~="icon"]', visible: false).count 
        expect(icon_link_count).to eql(1)  
 
        page.all(:css, 'link[rel~="icon"]', visible: false).each do |fav|  
            visit fav[:href]  
            expect(page).to have_http_status(:success)  
        end  
    end 
 
 end  
