class User < ActiveRecord::Base
has_many :reviews
has_secure_password validations: false
validates :name, presence: true
validates :password, presence: true, length: {minimum: 4}
validates :email, uniqueness: true
has_many :queue_items
end