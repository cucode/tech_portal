class User < ActiveRecord::Base
  ROLES = %w(editor admin superadmin)


  # Mixins

  has_paper_trail
  acts_as_taggable_on :roles

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :omniauthable, :database_authenticatable,# :registerable,
         :recoverable, :rememberable, :trackable, :validatable


  # Relationships and scopes

  has_many :authentications, dependent: :destroy


  # Public Methods

  def role?(role)
    role_list.include?(role.to_s)
  end


end
