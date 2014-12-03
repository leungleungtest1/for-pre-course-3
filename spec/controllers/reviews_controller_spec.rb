require 'spec_helper'
require 'fabrication'
require 'faker'

describe ReviewsController do
  describe 'POST create' do
    context 'without anthenticated' do
      it "redirect to sign in path" do
      post :create 
      expect(response).to redirect_to sign_in_path
    end
    end
    context 'with anthenticated' do
      before :each do
        @video = Fabricate(:video)
        @user = Fabricate(:user)
        session[:user_id] = @user.id
      end
      context 'invalid input' do
        it "cannot save a review successfully" do
          post :create, review: {rating: nil, description: "dddddd",user_id: @user.id, video_id:@video.id}, video_id:@video.id
          expect(assigns(:review)).to be_a_new(Review)
        end
        it "redirect the current page" do 
          post :create, review: {rating: nil, description: "dddddd",user_id: @user.id, video_id:@video.id}, video_id:@video.id
          expect(response).to redirect_to video_path(@video)
        end
        it 'flash the errors message' do
          post :create, review: {rating: nil, description: "dddddd",user_id: @user.id, video_id:@video.id}, video_id:@video.id
          expect(flash[:error]).not_to be_nil
        end
      end
      context 'valid input' do 
        it "create and save a review successfully" do
          post :create, review: {rating: 5, description: "dddddd",user_id: @user.id, video_id:@video.id}, video_id:@video.id
          expect(assigns(:review)).not_to be_a_new(Review)
        end
        it "set the review is belonging to current user" do
          post :create, review: {rating: 5, description: "dddddd",  video_id:@video.id}, video_id:@video.id
          expect(assigns(:review).user.id).to eq(session[:user_id])
        end
        it "render the current template" do
          post :create, review: {rating: 5, description: "dddddd",user_id: @user.id, video_id:@video.id}, video_id:@video.id
          expect(response).to render_template("videos/show")
        end
        it "flash the success message" do
          post :create, review: {rating: 5, description: "dddddd",user_id: @user.id, video_id:@video.id}, video_id:@video.id
          expect(flash[:success]).not_to be_nil
        end
      end
    end
  end
end