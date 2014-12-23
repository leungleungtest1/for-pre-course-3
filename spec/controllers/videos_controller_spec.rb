require 'spec_helper'
require 'fabrication'
require 'faker'

describe VideosController do 
  describe "GET show" do
    context "with authenticated users" do
      before do
        session[:user_id] = 1
      end
      it "sets variables @video" do
        video1 = Fabricate(:video)
        get :show,  id: video1.id
        expect(assigns(:video)).to eq(video1)
      end
      it "redirect to show template" do
        video2 = Fabricate(:video)
        get :show, id: video2.id
        expect(response).to render_template('show')
      end
    end
      context "with unauthenticated users" do
      it "redirects the user to the sign in page" do
        video2 = Fabricate(:video)
        get :show, id: video2.id
        expect(response).to redirect_to(sign_in_path)
      end
    end
  end

  describe "POST search"do
    context "with authenticated users" do
      before do
        session[:user_id] = Fabricate(:user).id
      end
      it "sets a variables @results" do
        video1 = Fabricate(:video, title: "Total War")
        post :search, search_term: "to"
        expect(assigns(:results)).to eq([video1])
      end
      it "render to 'search' template" do
        post :search, search_term: "to"
        expect(response).to render_template('search') 
      end
    end
    it "redirect_to sign in page with an unauthenticated user" do
      video1 = Fabricate(:video, title: "Total War")
      post :search, search_term: "war"
      expect(response).to redirect_to(sign_in_path)
    end
  end


  
end