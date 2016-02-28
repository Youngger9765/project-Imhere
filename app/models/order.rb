class Order < ActiveRecord::Base
  belongs_to :user
  belongs_to :merchant, :counter_cache => true
end
