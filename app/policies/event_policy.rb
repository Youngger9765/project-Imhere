class EventPolicy < ApplicationPolicy  
  attr_reader :user, :event

  def initialize(user, event)
    @user = user
    @event = event
  end

  def index?
    user.admin?  #重點
    raise
  end

  def show?
    user.admin? 
  end
end  