class User < ActiveRecord::Base
  has_many :authentications, :dependent => :destroy
  
  has_paper_trail
  acts_as_taggable_on :roles
  
  ROLES = %w(editor admin superadmin)
  
  def role?(role)
    role_list.include?(role.to_s)
  end
  
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :omniauthable, :database_authenticatable,# :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
