shared_examples "require_sign_in" do
  it "redirects to the front page" do
    action
    session[:user_id]= nil
    expect(response).to redirect_to sign_in_path
  end
end