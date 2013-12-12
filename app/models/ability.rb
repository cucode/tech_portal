class Ability
  include CanCan::Ability

  def initialize(user)
    return unless user

    can :show, :events do |org|
      org.published?
    end

    can :new, :organizations
    can :update, :organizations do |org|
      user.has_role?(:editor, org)
    end
    can :show, :organizations do |org|
      org.published?
    end

    if user.has_role?(:editor)
      can [:read], :events do |event|
        event.organization && user.has_role?(:editor, event.organization) || event.published
      end
      can [:update, :destroy], :events do |event|
        event.organization && user.has_role?(:editor, event.organization)
      end

      can [:read], :organizations do |org|
        user.has_role?(:editor, org) || org.published?
      end
      can [:update, :destroy], :organizations do |org|
        user.has_role?(:editor, org)
      end
    end

    if user.has_role?(:admin)
      can :create, :all
      can :update, :all
      can :read, :all
      can :destroy, :all

      can :publish, :events
      can :unpublish, :events

      can :publish, :organizations
      can :unpublish, :organizations

      can :import, :events
    end
  end
end
