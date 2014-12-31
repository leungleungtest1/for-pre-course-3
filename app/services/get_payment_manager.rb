class GetPaymentManager
  attr_accessor :user, :state, :error_message
  def initialize(user,state=nil,error_message=nil)
    @user = user
    @state = state
    @error_message = error_message
  end

  def user_sign_up(token,invitor=nil)
    if user.valid?
      customer = StripeWrapper::Customer.create({:amount => 999, :card => token, :description => "payment from #{user.name}, #{user.email}"} )
        if customer.successful?
          user.customer_token = customer.customer_token
          becomes_friend(user,invitor)
          invitor.update_column(:token, SecureRandom.urlsafe_base64) if invitor
          AppMailer.send_welcome_email(user).deliver
          user.save
          self.state = :success
        else
          user.destroy
          self.error_message = customer.error_message
          self.state = :false
        end
      
     else
      self.error_message = user.errors.full_messages.join(', ')
      self.state = :false
    end
  end

  def successful?
    self.state == :success
  end

  private
  def becomes_friend(user, invitor)
    Relationship.create(leader_id: user.id,follower_id: invitor.id) if invitor
    Relationship.create(leader_id: invitor.id,follower_id: user.id) if invitor 
  end
end 