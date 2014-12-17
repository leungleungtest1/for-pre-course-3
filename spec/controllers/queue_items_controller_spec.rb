require 'spec_helper'
require 'fabrication'
require 'faker'

describe QueueItemsController do
  describe "GET index" do
    context "set the tests" do
      let_alice
      let(:monk) {Fabricate(:video)}
      let(:queue_item1) {Fabricate(:queue_item, user: alice)}
      let(:queue_item2) {Fabricate(:queue_item, user:alice, video:monk)}
      before do 
        session[:user_id] = alice.id
      end
      it "sets @queue_items to the queue items of the logged in user" do
        get :index
        expect(assigns(:queue_items)).to match_array([queue_item1,queue_item2])
      end
    end

    it_behaves_like "require_sign_in" do
      let(:action) {get :index}
    end
      
  end

  describe "POST create" do
    context "with authenticated user" do
        let(:user) {Fabricate(:user)}
        before do
          session[:user_id] = user.id
        end
      it "create a new queue_item." do
        @video = Fabricate(:video)
        post :create, video_id: @video.id
        expect(assigns(:queue_item)).to be_a_instance_of(QueueItem)
      end
      it "create the new queue_item that is associated with the video" do
        @video = Fabricate(:video)
        post :create, video_id: @video.id
        expect(assigns(:queue_item).video).to eq(@video)
      end
      it "create the new queue_item that is associated with the current user" do
        @video = Fabricate(:video)
        post :create, video_id: @video.id
        expect(assigns(:queue_item).user).to eq(user)
      end
      it "place the video as the last one in the queue" do
        @video = Fabricate(:video)
        @video2 = Fabricate(:video)
        create_second_last_queue
        post :create, video_id: @video2.id
        expect(assigns(:queue_item).position).to eq(2)
      end
      it "does not add the video to the queue if the video is already in the queue" do
        @video = Fabricate(:video)
        create_second_last_queue
        post :create, video_id: @video.id 
        expect(user.queue_items.count).to eq(1)
      end
      it "redirects to my_queue when a queue_item create successfully."  do
        @video = Fabricate(:video)
        post :create, video_id: @video.id
        expect(response).to redirect_to my_queue_path      
      end
    end
    it_behaves_like "require_sign_in" do
      let(:action) {post :create, video_id: 1}
    end
  end

  describe "DELETE destroy" do
    context "With authenticated user" do
      before do
        set_current_user_alice
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
      it "normalize the remaining queue item" do 
        queue_item2 = Fabricate(:queue_item, user: @alice)
        delete :destroy, id: @queue_item.id
        expect(queue_item2.reload.position).to eq(1)
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

  describe "POST update_queue" do
    context "with valid input" do
      let(:alice) {Fabricate(:user)}
      let(:queue_item1) {Fabricate(:queue_item, user: alice, position:1)}
      let(:queue_item2) {Fabricate(:queue_item, user: alice, position:2)} 
      it "redirects to my queue page" do
        set_current_user(alice)
        post :update_queue, queue_item: [{id: queue_item1.id, position:1},{id:queue_item2.id, position: 2}]
        expect(response).to redirect_to my_queue_path
      end
      it "orders the queue items" do
        set_current_user(alice)
        monk = Fabricate(:video)
        family_guy = Fabricate(:video)
        queue_item1 = Fabricate(:queue_item, user: alice, video: monk,position: 5)
        queue_item2 = Fabricate(:queue_item, user: alice, video: family_guy,position: 6)
        post :update_queue, queue_item: [{id: queue_item1.id, position: 4, rating: 1},{id:queue_item2.id, position: 3, rating: 1}]
        expect(alice.queue_items).to eq([queue_item2,queue_item1])
      end
      it "normalize the position numbers" do
        set_current_user(alice)
        post :update_queue, queue_item: [{id: queue_item1.id, position: 3},{id:queue_item2.id, position: 4}]
        expect(QueueItem.all.map(&:position)).to eq([1,2])
      end

      it "update the rating when a review of it exists" do 
        monk = Fabricate(:video)
        family_guy = Fabricate(:video)
        review_of_m1 = Fabricate(:review,user: alice,video:monk)
        review_of_f2 = Fabricate(:review,user: alice,video:family_guy)
        session[:user_id] = alice.id
        queue_item1 = Fabricate(:queue_item, user: alice, position: 1, video: monk)
        queue_item2 = Fabricate(:queue_item, user: alice, position: 2, video: family_guy)
        post :update_queue, queue_item: [{id: queue_item1.id, position: 1,rating: 5},{id:queue_item2.id, position: 2, rating: 3}]
        expect(QueueItem.all.map(&:rating)).to eq([5,3])
      end
      it "create a review of rating when a review of it exists" do
        monk = Fabricate(:video)
        family_guy = Fabricate(:video)
        session[:user_id] = alice.id
        queue_item1 = Fabricate(:queue_item, user: alice, position: 1, video: monk)
        queue_item2 = Fabricate(:queue_item, user: alice, position: 2, video: family_guy)
        post :update_queue, queue_item: [{id: queue_item1.id, position: 1,rating: 5},{id:queue_item2.id, position: 2, rating: 3}]
        expect(QueueItem.all.map(&:rating)).to eq([5,3])
      end
    end
    context "with invalid input" do
      it "redirects my queue page" do
        alice = Fabricate(:user)
        set_current_user(alice)
        queue_item1 = Fabricate(:queue_item, user: alice, position: 1)
        queue_item2 = Fabricate(:queue_item, user: alice, position: 2)
        post :update_queue, queue_item: [{id: queue_item1.id, position: 3},{id:queue_item2.id, position: 4.6}]
        expect(response).to redirect_to my_queue_path
      end
      it "sets the flash error message" do
        alice = Fabricate(:user)
        set_current_user(alice)
        queue_item1 = Fabricate(:queue_item, user: alice, position: 1)
        queue_item2 = Fabricate(:queue_item, user: alice, position: 2)
        post :update_queue, queue_item: [{id: queue_item1.id, position: 3},{id:queue_item2.id, position: 4.6}]
        expect(flash[:error]).to be_present
      end
      it " does not change the queue items" do
        alice = Fabricate(:user)
        set_current_user(alice)
        queue_item1 = Fabricate(:queue_item, user: alice, position: 1)
        queue_item2 = Fabricate(:queue_item, user: alice, position: 2)
        post :update_queue, queue_item: [{id: queue_item1.id, position: 4.6},{id:queue_item2.id, position: 4}]
        expect(QueueItem.all.map(&:position)).to eq([1,2])
      end
 
      #it "does not change the rating." do
        #alice = Fabricate(:user)
        #monk = Fabricate(:video)
        #family_guy = Fabricate(:video)
        #review_of_m1 = Fabricate(:review,user: alice,video:monk,rating: 1)
        #review_of_f2 = Fabricate(:review,user: alice,video:family_guy,rating: 2)
        #session[:user_id] = alice.id
        #queue_item1 = Fabricate(:queue_item, user: alice, position: 1, video: monk)
        #queue_item2 = Fabricate(:queue_item, user: alice, position: 2, video: family_guy)
        #post :update_queue, queue_item: [{id: queue_item1.id, position: 1,rating: 3},{id:queue_item2.id, position: 2, rating: "string"}]
        #expect(QueueItem.all.map(&:rating)).to eq([1,2])
      #end
      it "does not create a review of the rating when it does not exit" do
        alice = Fabricate(:user)
        monk = Fabricate(:video)
        family_guy = Fabricate(:video)
        set_current_user(alice)
        queue_item1 = Fabricate(:queue_item, user: alice, position: 1, video: monk)
        queue_item2 = Fabricate(:queue_item, user: alice, position: 2, video: family_guy)
        post :update_queue, queue_item: [{id: queue_item1.id, position: 1,rating: 3},{id:queue_item2.id, position: 2, rating: "string"}]
        expect(Review.count).to eq(1)
      end
    end
    context "with unauthenticated users" do
      it "redirect_to sign_in page" do
        alice = Fabricate(:user)
        queue_item1 = Fabricate(:queue_item, user: alice, position: 1)
        queue_item2 = Fabricate(:queue_item, user: alice, position: 2)
        post :update_queue, queue_item: [{id: queue_item1.id, position: 3},{id:queue_item2.id, position: 4.6}]
        expect(response).to redirect_to sign_in_path
      end
    end
    context "with queue_item that do not belong to the current" do 
      it "does not queue the queue item." do
        alice = Fabricate(:user)
        set_current_user(alice)
        bob = Fabricate(:user)
        queue_item1 = Fabricate(:queue_item, user: bob, position: 1)
        queue_item2 = Fabricate(:queue_item, user: bob, position: 2)
        post :update_queue, queue_item: [{id: queue_item1.id, position: 4},{id:queue_item2.id, position: 3}]
        expect(queue_item1.reload.position).to eq(1)
      end

      it "does not change the change" do
        alice = Fabricate(:user)
        monk = Fabricate(:video)
        family_guy = Fabricate(:video)
        review_of_m1 = Fabricate(:review,user: alice,video:monk,rating:1)
        review_of_f2 = Fabricate(:review,user: alice,video:family_guy, rating:3)
        queue_item1 = Fabricate(:queue_item, user: alice, position: 1, video: monk)
        queue_item2 = Fabricate(:queue_item, user: alice, position: 2, video: family_guy)
        post :update_queue, queue_item: [{id: queue_item1.id, position: 1,rating: 5},{id:queue_item2.id, position: 2, rating: 3}]
        expect(QueueItem.all.map(&:rating)).to eq([1,3])
      end
      it "does not create a review of the rating when it does not exit" do
        bob = Fabricate(:user)
        alice = Fabricate(:user)
        monk = Fabricate(:video)
        family_guy = Fabricate(:video)
        set_current_user(bob)
        queue_item1 = Fabricate(:queue_item, user: alice, position: 1, video: monk)
        queue_item2 = Fabricate(:queue_item, user: alice, position: 2, video: family_guy)
        post :update_queue, queue_item: [{id: queue_item1.id, position: 1,rating: 5},{id:queue_item2.id, position: 2, rating: 3}]
        expect(QueueItem.all.map(&:rating)).to eq([nil,nil])
      end
    end
  end
end