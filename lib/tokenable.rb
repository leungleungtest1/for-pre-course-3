module Tokenable
  extend ActiveSupport::Concern

  included do
    before_create :create_token_for_new_user

    private
    
    def create_token_for_new_user
      self.token = SecureRandom.urlsafe_base64
    end
  end
end