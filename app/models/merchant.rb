class Merchant < ActiveRecord::Base

  belongs_to :merchantable, :polymorphic => true
end
