class Activity < ActiveRecord::Base
  validates_presence_of :name

  belongs_to :event

  has_attached_file :logo_in_event, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :logo_in_event, content_type: /\Aimage\/.*\Z/

  has_attached_file :banner, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :banner, content_type: /\Aimage\/.*\Z/

  has_attached_file :logo, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :logo, content_type: /\Aimage\/.*\Z/

  has_attached_file :information_picture, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :information_picture, content_type: /\Aimage\/.*\Z/

  has_attached_file :merchant_banner, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :merchant_banner, content_type: /\Aimage\/.*\Z/

  has_many :activity_milestones
  has_many :lotteries

  has_many :user_activity_favoritings, dependent: :destroy
  has_many :users, :through => :user_activity_favoritings

  has_many :merchants, :as => :merchantable

  has_many :activity_artist_ships
  has_many :artists, :through => :activity_artist_ships

  geocoded_by :location
  after_validation :geocode

  def public?
    self.status == "1"
  end

  def status_word
    if self.status == 0
      "隱藏"
    elsif self.status == 1
      "公開上架"
    end
  end

  def get_achievement
    customers_target = self.customers_target
    merchant_people_count = self.merchants.sum(:orders_count)
    lottery_people_count = self.lotteries.sum(:users_count)
    
    if customers_target && customers_target > 0
      achievement = (lottery_people_count.to_f + merchant_people_count.to_f)*100 / customers_target.to_f
      achievement = achievement.to_i
    else
      achievement = "目標尚未設定或設定錯誤"
    end
  end

  def artist_id
    
  end
end
