require "open-uri"

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable, 
         :omniauthable, :omniauth_providers => [:facebook]
  
  validates :name, presence: true         
  validates_with EmailDomainValidator

  before_create :generate_authentication_token

  has_attached_file :head_shot, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :head_shot, content_type: /\Aimage\/.*\Z/

  belongs_to :role
  before_create :set_default_role

  has_many :user_lottery_ships
  has_many :lotteries, :through => :user_lottery_ships

  has_many :orders

  geocoded_by :address
  after_validation :geocode

  def admin?
    if self.role
      self.role.name == 'admin'
    else
      false
    end
  end

  def generate_authentication_token
    self.authentication_token = Devise.friendly_token
  end

  def self.get_fb_data(access_token)
    res = RestClient.get "https://graph.facebook.com/v2.4/me",  
    { :params => { :access_token => access_token, :fields =>["id", "name", "email", "picture"] } }

    if res.code == 200
      JSON.parse( res.to_str )
    else
      Rails.logger.warn(res.body)
      nil
    end
  end

  def self.from_omniauth(auth)
      # Case 1: Find existing user by facebook uid
    user = User.find_by_fb_uid( auth.uid )
    if user
      user.fb_name = auth[:info][:name]
      user.fb_email = auth[:info][:email]
      user.fb_head_shot = auth[:info][:image]
      user.fb_token = auth.credentials.token
      user.fb_raw_data = auth
      user.skip_confirmation! 
      user.save!
      return user
    end

    # Case 2: Find existing user by email
    existing_user = User.find_by_email( auth.info.email )
    if existing_user

      if existing_user.head_shot_file_name.nil? && auth.info.image.present?
        image_url = existing_user.process_uri(auth.info.image)
        existing_user.head_shot = URI.parse(image_url)
      end

      existing_user.fb_name = auth[:info][:name]
      existing_user.fb_email = auth[:info][:email]
      existing_user.fb_head_shot = auth[:info][:image]
      existing_user.fb_uid = auth.uid
      existing_user.fb_token = auth.credentials.token
      existing_user.fb_raw_data = auth
      existing_user.skip_confirmation! 
      existing_user.save!
      return existing_user
    end

    # Case 3: Create new password
    user = User.new
    user.name = auth.info.name
    user.email = auth.info.email
    user.password = Devise.friendly_token[0,20]

    if auth.info.image.present?
      image_url = user.process_uri(auth.info.image)
      user.head_shot = URI.parse(image_url)
    end
    
    # fb info
    user.fb_uid = auth.uid
    user.fb_token = auth.credentials.token
    user.fb_raw_data = auth
    user.fb_name = auth[:info][:name]
    user.fb_email = auth[:info][:email]
    user.fb_head_shot = auth[:info][:image]
    user.skip_confirmation! 
    user.save!
    return user
  end

  def set_default_role
    self.role ||= Role.find_by_name('registered')
  end

  def process_uri(uri)
    require 'open-uri'
    require 'open_uri_redirections'
    open(uri, :allow_redirections => :safe) do |r|
      r.base_uri.to_s
    end
  end

end
