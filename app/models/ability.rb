class Ability
  include CanCan::Ability

  def initialize(user)
    return unless user

    can :manage, :all
    can :publish, :all
    can :unpublish, :all
  end
end
