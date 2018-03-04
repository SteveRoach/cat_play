require "rails_helper"  
 
RSpec.feature "Render Static Pages", :type => :feature do  
    scenario "displays the Home page elements correctly" do  
        visit "/"  
 
        # Page title 
        expect(page).to have_title('Cat Play')  
 
        # Favicon
        icon_link_count = page.all(:css, 'link[rel~="icon"]', visible: false).count 
        expect(icon_link_count).to eql(1)  
 
        page.all(:css, 'link[rel~="icon"]', visible: false).each do |fav|  
            visit fav[:href]  
            expect(page).to have_http_status(:success)  
        end  
    end 
 
    scenario "displays the About page elements correctly" do  
        visit "/about" 
 
        # Page title 
        expect(page).to have_title('Cat Play | About')  
 
        # Favicon
        icon_link_count = page.all(:css, 'link[rel~="icon"]', visible: false).count 
        expect(icon_link_count).to eql(1)  
 
        page.all(:css, 'link[rel~="icon"]', visible: false).each do |fav|  
            visit fav[:href]  
            expect(page).to have_http_status(:success)  
        end  
    end 
 
    scenario "displays the Journal page elements correctly" do  
        visit "/journal" 
 
        # Page title 
        expect(page).to have_title('Cat Play | Journal')  
 
        # Favicon
        icon_link_count = page.all(:css, 'link[rel~="icon"]', visible: false).count 
        expect(icon_link_count).to eql(1)  
 
        page.all(:css, 'link[rel~="icon"]', visible: false).each do |fav|  
            visit fav[:href]  
            expect(page).to have_http_status(:success)  
        end  
    end 
 
    scenario "displays the Technical page elements correctly" do  
        visit "/technical"  
 
        # Page title 
        expect(page).to have_title('Cat Play | Technical')  
 
        # Favicon
        icon_link_count = page.all(:css, 'link[rel~="icon"]', visible: false).count 
        expect(icon_link_count).to eql(1)  
 
        page.all(:css, 'link[rel~="icon"]', visible: false).each do |fav|  
            visit fav[:href]  
            expect(page).to have_http_status(:success)  
        end  
    end 
 
    scenario "displays the Crew page elements correctly" do  
        visit "/crew"  
 
        # Page title 
        expect(page).to have_title('Cat Play | Crew')  
 
        # Favicon
        icon_link_count = page.all(:css, 'link[rel~="icon"]', visible: false).count 
        expect(icon_link_count).to eql(1)  
 
        page.all(:css, 'link[rel~="icon"]', visible: false).each do |fav|  
            visit fav[:href]  
            expect(page).to have_http_status(:success)  
        end  
    end 
 
    scenario "displays the Gallery page elements correctly" do  
        visit "/gallery"  
 
        # Page title 
        expect(page).to have_title('Cat Play | Gallery')  
 
        # Favicon
        icon_link_count = page.all(:css, 'link[rel~="icon"]', visible: false).count 
        expect(icon_link_count).to eql(1)  
 
        page.all(:css, 'link[rel~="icon"]', visible: false).each do |fav|  
            visit fav[:href]  
            expect(page).to have_http_status(:success)  
        end  
    end 
 
    scenario "displays the Admin page elements correctly" do  
        visit "/admin"  
 
        # Page title 
        expect(page).to have_title('Cat Play | Log In')  
 
        # Favicon
        icon_link_count = page.all(:css, 'link[rel~="icon"]', visible: false).count 
        expect(icon_link_count).to eql(1)  
 
        page.all(:css, 'link[rel~="icon"]', visible: false).each do |fav|  
            visit fav[:href]  
            expect(page).to have_http_status(:success)  
        end  
    end 
 
end  
 