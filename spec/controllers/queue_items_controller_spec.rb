require 'spec_helper'
require 'fabrication'
require 'faker'

describe QueueItemsController do
  describe "GET index" do
    it "sets @queue_items to the queue items of the logged in user" do
      alice = Fabricate(:user)
      monk = Fabricate(:video)
      session[:user_id] = alice.id
      queue_item1 = Fabricate(:queue_item, user: alice)
      queue_item2 = Fabricate(:queue_item, user: alice, video: monk)
      get :index
      expect(assigns(:queue_items)).to match_array([queue_item1,queue_item2])
    end

    it "redirects to the sing in page for unauthenticated users" do
      get :index
      expect(response).to redirect_to sign_in_path
    end
  end

  describe "POST create" do
    it "create a new queue_item." do
      @video = Fabricate(:video)
      user = Fabricate(:user)
      session[:user_id] = user.id
      post :create, video_id: @video.id
      expect(assigns(:queue_item)).to be_a_instance_of(QueueItem)
    end
    it "create the new queue_item that is associated with the video" do
      @video = Fabricate(:video)
      user = Fabricate(:user)
      session[:user_id] = user.id
      post :create, video_id: @video.id
      expect(assigns(:queue_item).video).to eq(@video)
    end
    it "create the new queue_item that is associated with the current user" do
      @video = Fabricate(:video)
      user = Fabricate(:user)
      session[:user_id] = user.id
      post :create, video_id: @video.id
      expect(assigns(:queue_item).user).to eq(user)
    end
    it "place the video as the last one in the queue" do
      @video = Fabricate(:video)
      user = Fabricate(:user)
      session[:user_id] = user.id
      second_last_queue = QueueItem.create(user: user, video: @video_id)
      second_last_queue.save
      post :create, video_id: @video.id
      expect(assigns(:queue_item).position).to eq(2)
    end
    it "does not add the video to the queue if the video is already in the queue" do
      @video = Fabricate(:video)
      user = Fabricate(:user)
      session[:user_id] = user.id
      second_last_queue = QueueItem.create(user: user, video: @video)
      second_last_queue.save
      post :create, video_id: @video.id
      expect(user.queue_items.count).to eq(1)
    end
    it "redirects to my_queue when a queue_item create successfully."  do
      @video = Fabricate(:video)
      user = Fabricate(:user)
      session[:user_id] = user.id
      post :create, video_id: @video.id
      expect(response).to redirect_to my_queue_path      
    end
    it "redirect_to sing in page for unauthenticated user" do
      post :create, video_id: 1
      expect(response).to redirect_to sign_in_path
    end
  end

  describe "DELETE destroy" do
    context "With authenticated user" do
      before do
        @alice = Fabricate(:user)
        session[:user_id] =  @alice.id
        @queue_item = Fabricate(:queue_item, user: @alice)
      end
        it "redirects to my_queue page"  do
        delete :destroy, id: @queue_item
        expect(response).to redirect_to my_queue_path
      end
      it "delele the queue item" do
        delete :destroy, id: @queue_item.id
        expect(QueueItem.count).to eq(0)
      end
      it "do not delete the queue_item when current user do not own the queue" do
        tommy = Fabricate(:user)
        queue_item_of_t = Fabricate(:queue_item, user: tommy)
        delete :destroy, id: queue_item_of_t.id
        expect(QueueItem.count).to eq(2)
      end
    end
    context "With unauthenticated user" do
      it "redirect_to sign_in_path" do
        @alice = Fabricate(:user)
        @queue_item = Fabricate(:queue_item, user: @alice)        
        delete :destroy, id: @queue_item
        expect(response).to redirect_to sign_in_path
      end
    end
  end
end