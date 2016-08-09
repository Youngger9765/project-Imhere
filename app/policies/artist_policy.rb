class ArtistPolicy < ApplicationPolicy  
  attr_reader :user, :artist

  def initialize(user, artist)
    @user = user
    @artist = artist
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

  def remove_from_activity?
    user.admin?
  end
end  