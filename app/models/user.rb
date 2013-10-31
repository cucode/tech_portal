class User < ActiveRecord::Base
  ROLES = %w(editor admin superadmin)


  # Mixins

  has_paper_trail
  acts_as_taggable_on :roles

  devise :omniauthable, :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable,
         :token_authenticatable


  # Relationships and scopes

  has_many :authentications, dependent: :destroy


  # Public Methods

  def role?(role)
    role_list.include?(role.to_s)
  end


end
