class User < ActiveRecord::Base

  # Mixins

  devise :omniauthable, :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable,
         :token_authenticatable

  has_paper_trail

  rolify


  # Relationships and scopes

  has_many :authentications, dependent: :destroy


end
