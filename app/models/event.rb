class Event < ActiveRecord::Base
  validates_presence_of :name

  has_many :activities

  has_attached_file :logo, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :logo, content_type: /\Aimage\/.*\Z/

  has_attached_file :banner, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :banner, content_type: /\Aimage\/.*\Z/
end
