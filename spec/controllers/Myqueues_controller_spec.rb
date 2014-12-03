require 'spec_helper'
require 'fabrication'
require 'faker'

describe MyqueuesController do
  describe 'GET index' do
    context "without authenticated user" do
      it "redirects to sign in page" do
        get :index
        expect(response).to redirect_to sign_in_path
      end
    end
    context "with authenticated user" do
      before  do
        @user = Fabricate(:user)
        session[:user_id] = @user.id
      end
        context "the myqueue of the user have no video" do 
          before do
            @myqueue = Myqueue.create(user: @user)
            video1 = Fabricate(:video)
          end
          it "return emyqueue of user which is a empty array" do
            get :index
            expect(assigns(:myqueue)).to be_a Myqueue
            expect(assigns(:myqueue).videos).to be_empty
            expect(assigns(:myqueue).user).to eq(@user)
          end
        end
        context "the myqueue of the user have one or more video" do
          before do
            @myqueue = Myqueue.create(user: @user)
            @video1 = Fabricate(:video)
            @review = Fabricate(:review, rating:5, user: @user, video: @video1)
            @video1.myqueues << @myqueue
            @video1.save
            @video2 = Fabricate(:video)
            @video2.myqueues << @myqueue
            @video2.save
          end
          it "gets a array of video" do
            get :index
            expect(assigns(:myqueue).videos).to include(@video1,@video2)
          end
          it "gets rating of the user and the video" do
            get :index
            expect(assigns(:myqueue).videos.first.reviews.find_by(user_id: @user.id).rating).to eq(5)
          end
        end

    end
  end
end