require 'spec_helper'

describe Admin::VideosController do
  describe 'GET add_video' do
    context "with authenticated user" do
      before do
        set_current_user_is_admin
      end
      it "sets a new variable" do
        get :add_video
        expect(assigns(:video)).to be_instance_of Video
        expect(assigns(:video)).to be_a_new(Video)
      end
      it "render a template of add_video" do
        get :add_video
        expect(response).to render_template :add_video
      end
    end
    it_behaves_like "require admin" do
      let(:action){post :create}
    end
    context "with unauthenticated user" do
      it "redirect to sign in page" do
        get :add_video
        expect(response).to redirect_to sign_in_path
      end
      it_behaves_like "require_sign_in" do
        let(:action) { get :add_video}
      end
    end
  end 

  describe "POST create" do
    it_behaves_like "require_sign_in" do
      let(:action) {post :create}
    end
    it_behaves_like "require admin" do
      let(:action){post :create}
    end
  end 
  context "with valid input" do
    it "create a video" do
      set_current_user_is_admin
      category = Fabricate(:category)
      post :create , video: {title: "Monk", category_id: category.id, description: "good show"}
      expect(category.videos.count).to eq(1)
    end
    it "redirects to the add new video page" do
      set_current_user_is_admin
      category = Fabricate(:category)
      post :create , video: {title: "Monk", category_id: category.id, description: "good show"}
      expect(response).to redirect_to admin_add_video_path
    end
    it "sets the flash success message" do
      set_current_user_is_admin
      category = Fabricate(:category)
      post :create , video: {title: "Monk", category_id: category.id, description: "good show"}
      expect(flash[:success]).to be_present
    end
  end
  context "with invalid input" do
    it "does not create a video" do
      set_current_user_is_admin
      category = Fabricate(:category)
      post :create , video: { category_id: category.id, description: "good show"}
      expect(category.videos.count).to eq(0)
    end
    it "render the add_video template" do
      set_current_user_is_admin
      category = Fabricate(:category)
      post :create , video: { category_id: category.id, description: "good show"}
      expect(response).to render_template "add_video"
    end
    it "set the @video variable" do
      set_current_user_is_admin
      category = Fabricate(:category)
      post :create , video: { category_id: category.id, description: "good show"}
      expect(assigns(:video)).to be_a_new Video
      expect(assigns(:video)).to be_instance_of Video
    end
    it "sets the flash danger message" do
      set_current_user_is_admin
      category = Fabricate(:category)
      post :create , video: { category_id: category.id, description: "good show"}
      expect(flash[:danger]).to be_present
    end
  end
end