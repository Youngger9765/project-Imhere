class UserActivityFavoriting < ActiveRecord::Base

  belongs_to :user, :counter_cache => :favoritings_count
  belongs_to :activity, :counter_cache => :favoritings_count

  before_create :set_last_view_time_to_now

  def set_last_view_time_to_now
    self.last_view_time = Time.now
  end
end
