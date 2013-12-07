class Ability
  include CanCan::Ability

  def initialize(user)
    return unless user

    can :new, :organizations
    can :update, :organizations do |org|
      user.has_role?(:editor, org)
    end

    if user.has_role?(:admin)
      can :import, :events
      can :manage, :all
      can :publish, :all
      can :unpublish, :all
    end
  end
end
