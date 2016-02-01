class Spec < ActiveRecord::Base
  belongs_to :merchant

  has_many :selections, :dependent => :destroy
  accepts_nested_attributes_for :selections, reject_if: :all_blank, allow_destroy: true
end
