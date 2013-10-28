class Ability
  include CanCan::Ability

  def initialize(user)
    if user && user.role?("superadmin")
      can :manage, :all
    end
  end
end
