class UserActivityFavoriting < ActiveRecord::Base

  belongs_to :user, :counter_cache => :favoritings_count
  belongs_to :activity, :counter_cache => :favoritings_count
end
