class ActivityMilestone < ActiveRecord::Base

  validates_presence_of :people

  belongs_to :activity
end
