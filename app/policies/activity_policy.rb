class ActivityPolicy < ApplicationPolicy  
  attr_reader :user, :activity

  def initialize(user, activity)
    @user = user
    @activity = activity
  end

  def index?
    user.admin?  #重點
  end

  def show?
    user.admin? 
  end

  def new?
    user.admin? 
  end

  def create?
    user.admin? 
  end

  def edit?
    user.admin? 
  end

  def update?
    user.admin? 
  end

  def destroy?
    user.admin? 
  end
end  