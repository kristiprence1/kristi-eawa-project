# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    if user.role.name == "admin"
      can :manage, Book
      can :manage, Journal
      can :manage, User
      can :manage, Reservation
      can :manage, Loan
    elsif user.role == "user"
      can :read, Book
      can :read, Journal
    end
  end
end
