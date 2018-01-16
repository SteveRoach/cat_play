require 'rails_helper' 
 
RSpec.describe StaticPagesController, type: :controller do 
 
  describe "GET #home" do 
    before(:each) { get :home } 
    it "returns http success" do 
      expect(response).to have_http_status(:success) 
    end 
    it "renders the layout; application" do 
      expect(response).to render_template(layout: :application) 
    end 
    it "renders the template; home" do 
      expect(response).to render_template(:home) 
    end 
  end 
 
  describe "GET #about" do 
    before(:each) { get :about } 
    it "returns http success" do 
      expect(response).to have_http_status(:success) 
    end 
    it "renders the layout; application" do 
      expect(response).to render_template(layout: :application) 
    end 
    it "renders the template; about" do 
      expect(response).to render_template(:about) 
    end 
  end 
 
  describe "GET #journal" do 
    before(:each) { get :journal } 
    it "returns http success" do 
      expect(response).to have_http_status(:success) 
    end 
    it "renders the layout; application" do 
      expect(response).to render_template(layout: :application) 
    end 
    it "renders the template; journal" do 
      expect(response).to render_template(:journal) 
    end 
  end 
 
  describe "GET #technical" do 
    before(:each) { get :technical } 
    it "returns http success" do 
      expect(response).to have_http_status(:success) 
    end 
    it "renders the layout; application" do 
      expect(response).to render_template(layout: :application) 
    end 
    it "renders the template; technical" do 
      expect(response).to render_template(:technical) 
    end 
  end 
 
  describe "GET #crew" do
    before(:each) { get :crew } 
    it "returns http success" do
      expect(response).to have_http_status(:success)
    end
    it "renders the layout; application" do 
      expect(response).to render_template(layout: :application) 
    end 
    it "renders the template; crew" do 
      expect(response).to render_template(:crew) 
    end 
  end

  describe "GET #gallery" do
    before(:each) { get :gallery } 
    it "returns http success" do
      expect(response).to have_http_status(:success)
    end
    it "renders the layout; application" do 
      expect(response).to render_template(layout: :application) 
    end 
    it "renders the template; gallery" do 
      expect(response).to render_template(:gallery) 
    end 
  end

end 

