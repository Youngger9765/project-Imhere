class Activity < ActiveRecord::Base
  validates_presence_of :name

  belongs_to :event

  has_attached_file :logo, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :logo, content_type: /\Aimage\/.*\Z/

  has_attached_file :information_picture, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :information_picture, content_type: /\Aimage\/.*\Z/

  has_many :activity_milestones

  has_many :merchants, :as => :merchantable

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
end
