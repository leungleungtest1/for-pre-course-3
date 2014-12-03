class User < ActiveRecord::Base
has_one :myqueue
has_many :reviews
has_secure_password validations: false
validates :name, presence: true
validates :password, presence: true, length: {minimum: 4}
validates :email, uniqueness: true
end