shared_examples "require_sign_in" do
  it "redirects to the front page" do
    action
    session[:user_id]= nil
    expect(response).to redirect_to sign_in_path
  end
end

shared_examples "generate_token" do
  it "generates token for its self when it is created" do
    instance = Fabricate(model)
    expect(instance.token).to be_present 
  end
end

shared_examples "require admin" do
  context "with non-admin user" do
    before do
      bob = Fabricate(:user)
      session[:user_id] = bob.id
    end
    it "redirect to home page" do 
      action
      expect(response).to redirect_to home_path
    end
    it "send a message of no access message" do
      action
      expect(flash[:danger]).to be_present
    end
  end

end