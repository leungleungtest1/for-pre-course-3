class AppMailer < ActionMailer::Base

  def send_welcome_email(user)
    @user = user
    mail to: user.email, from: "info@myflix.com", subject: "Welcome to Myflix!"

  end
  def set_pp_email(user)
    @user= user
    mail to: user.email, from: "info@myflix.com", subject: "Reset your password"
  end

  def send_invitation_email(user, invitee_name, email, message)
    @user = user
    @invitee_name = invitee_name
    @email = email
    @message = message
    mail to: @email, from: "info@myflix.com", subject: "Invitation to Myflix website from #{@user_name}"
  end

  def send_simple_message
  RestClient.post "https://api:key-e8e4462efefd4160a545d0daa6444589"\
  "@api.mailgun.net/v2/sandboxa37872685f3649dd9ff329734bbd35bd.mailgun.org/messages",
  :from => "Mailgun Sandbox <postmaster@sandboxa37872685f3649dd9ff329734bbd35bd.mailgun.org>",
  :to => "leungleung <leungleungtest1@gmail.com>",
  :subject => "Hello leungleung",
  :text => "Congratulations leungleung, you just sent an email with Mailgun!  You are truly awesome!  You can see a record of this email in your logs: https://mailgun.com/cp/log .  You can send up to 300 emails/day from this sandbox server.  Next, you should add your own domain so you can send 10,000 emails/month for free."
end
end
