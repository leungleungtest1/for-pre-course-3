def set_current_user_alice
  @alice = Fabricate(:user)
  session[:user_id]=@alice.id
end

def set_current_user_nil
  session[:user_id]=nil
end

def let_alice
  let(:alice) {Fabricate(:user)}
end

def create_second_last_queue
  second_last_queue = QueueItem.create(user: user, video: @video, position: 1)
  second_last_queue.save
end

def set_current_user(user=nil)
  session[:user_id]=(user.id || Fabricate(:user).id)
end

def sign_in(a_user=nil)
  user = a_user || Fabricate(:user)
  visit sign_in_path
  fill_in "Email Address", with: user.email
  fill_in "Password", with: user.password 
  click_button "Sign in"
end

def click_on_video_on_home_page(video)
  find(:xpath, "//a[@href='videos/#{video.id}']").click  
end