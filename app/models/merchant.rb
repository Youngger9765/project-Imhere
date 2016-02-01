class Merchant < ActiveRecord::Base

  belongs_to :merchantable, :polymorphic => true

  has_attached_file :logo, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :logo, content_type: /\Aimage\/.*\Z/

  has_many :specs, :dependent => :destroy
  accepts_nested_attributes_for :specs, reject_if: :all_blank, allow_destroy: true
end
