require 'rails_helper'   
   
RSpec.describe GalleryController, type: :controller do   
   
  describe "GET #boat" do  
    before(:each) { get :boat }   
 
    it "returns http success" do  
      expect(response).to have_http_status(:success)  
    end  
 
    it "renders the layout; application" do   
      expect(response).to render_template(layout: :application)   
    end   
 
    it "renders the template; boat" do   
      expect(response).to render_template(:boat)  
    end  
  end  
  
  describe "GET #cats" do  
    before(:each) { get :cats }   
 
    it "returns http success" do  
      expect(response).to have_http_status(:success)  
    end  
 
    it "renders the layout; application" do   
      expect(response).to render_template(layout: :application)   
    end   
 
    it "renders the template; cats" do   
      expect(response).to render_template(:cats)  
    end  
  end  
  
  describe "GET #people" do  
    before(:each) { get :people }   
 
    it "returns http success" do  
      expect(response).to have_http_status(:success)  
    end  
 
    it "renders the layout; application" do   
      expect(response).to render_template(layout: :application)   
    end   
 
    it "renders the template; people" do   
      expect(response).to render_template(:people)  
    end  
  end  
  
end  
