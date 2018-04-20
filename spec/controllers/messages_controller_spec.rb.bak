require 'rails_helper'   
   
RSpec.describe MessagesController, type: :controller do   
   
  describe "GET #new" do  
    before(:each) { get :new }   
 
    it "returns http success" do  
      expect(response).to have_http_status(:success)  
    end  
 
    it "renders the layout; application" do   
      expect(response).to render_template(layout: :application)   
    end   
 
    it "renders the template; new" do   
      expect(response).to render_template(:new)  
    end  
  end  
  
end  
