class Lottery < ActiveRecord::Base

  validates_presence_of :name
  
  belongs_to :activity

  has_attached_file :logo, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :logo, content_type: /\Aimage\/.*\Z/

  has_many :user_lottery_ships
  has_many :users, :through => :user_lottery_ships

  has_many :prizes
end
