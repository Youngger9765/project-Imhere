class Lottery < ActiveRecord::Base

  validates_presence_of :name, :message => "名稱不得空白！"
  validates_presence_of :fan_page_name, :message => "粉絲團名稱不得空白！"
  validates_presence_of :fan_page_url, :message => "粉絲團連結不得空白！"
  validates_format_of :fan_page_url, :with =>  /(^$)|(^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$)/ix, :message => "粉絲團url 格式錯誤"
  validates_format_of :url, :with =>  /(^$)|(^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$)/ix, :message => "獎品介紹url 格式錯誤"
  
  belongs_to :activity

  has_attached_file :logo, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :logo, content_type: /\Aimage\/.*\Z/

  has_many :user_lottery_ships
  has_many :users, :through => :user_lottery_ships

  has_many :prizes

  def self.get_winner_all
    lotteries = Lottery.where("end_time < ? AND got_winner = ? AND status =?", Time.now, 0, 1)
    
    lotteries.each do |lottery|
      lottery.get_winner 
    end
  end

  def self.refresh_winner(num)
    lottery = Lottery.find(num)
    lottery.update(:got_winner => 0)
    lottery.user_lottery_ships.update_all(:winner => 0)
  end

  def get_winner
    rand_users = self.users.order("RANDOM()")
    count_array = [self.win_people, self.users_count]
    winners = rand_users.limit(count_array.min)

    winners.each do |winner|
      winner.user_lottery_ships.find_by(:lottery_id => self).update(:winner => 1)
    end

    self.update(:got_winner => 1)
  end

  def clean_winner
    self.update(:got_winner => 0)
    self.user_lottery_ships.update_all(:winner => 0)
  end

  def refresh_winner
    self.clean_winner
    self.get_winner
  end

  def self.aaa
    logger.debug "hello=================================="
    logger.debug "hello=================================="
  end
end
