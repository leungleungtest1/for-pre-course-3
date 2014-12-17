require "spec_helper"
  
describe InvitationController do
  describe "POST send invitation" do
    context "with authenticated user" do
      before do
        set_current_user_alice
      end
      context "when valid input" do
        it "sends a email" do
          post :send_invitation, name: "justin", email: "justin@email.com"
          expect(ActionMailer::Base.deliveries).not_to be_empty
        end
        it "sends a email with correct email" do
          post :send_invitation, name: "justin", email: "justin@email.com"
          expect(ActionMailer::Base.deliveries.last.to).to eq(["justin@email.com"])
        end
        it "gives a flash[:success]" do
          post :send_invitation, name: "justin", email: "justin@email.com"
          expect(flash[:success]).to be_present
        end
        it "redirect to invitation page" do
          post :send_invitation, name: "justin", email: "justin@email.com"
          expect(response).to redirect_to invite_friends_path
        end
      end
      context "when invalid input" do
        it "does not a email with invalid email" do
          ActionMailer::Base.deliveries =[]
          post :send_invitation, name: "justin", email: "i_not_email address"
          expect(ActionMailer::Base.deliveries).to be_empty
        end
        it "does not a email with empty email" do
          ActionMailer::Base.deliveries = []
          post :send_invitation, name: "justin"
          expect(ActionMailer::Base.deliveries).to be_empty
        end
        it "gives a flash[:danger]" do
          post :send_invitation, name: "justin"
          expect(flash[:danger]).to be_present
        end
        it "redirect to invitation page" do
          post :send_invitation, name: "justin"
          expect(response).to redirect_to invite_friends_path
        end
      end
    end
    context "with unauthenticated user" do 
      it "does not a email" do
        ActionMailer::Base.deliveries =[]
        post :send_invitation
        expect(ActionMailer::Base.deliveries).to be_empty
      end
      it "gives a flash[:danger]" do
        post :send_invitation
        expect(flash[:danger]).to be_present
      end
      it_behaves_like "require_sign_in" do
        let(:action) {post :send_invitation}
      end
    end
  end
end