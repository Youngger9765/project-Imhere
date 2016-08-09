class Artist < ActiveRecord::Base
  validates_presence_of :name, :message => "請輸入藝人名稱"
  validates_uniqueness_of :name, :message => "已經有相同藝人名稱"

  validates_format_of :fb_link, :with =>  /(^$)|(^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$)/ix, :message => "fb url 格式錯誤"
  validates_format_of :youtube_link, :with =>  /(^$)|(^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$)/ix, :message => "youtube url 格式錯誤"
  validates_format_of :ig_link, :with =>  /(^$)|(^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$)/ix, :message => "ig url 格式錯誤"
  validates_format_of :webo_link, :with =>  /(^$)|(^(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(([0-9]{1,5})?\/.*)?$)/ix, :message => "微博 url 格式錯誤"

  has_many :activity_artist_ships
  has_many :activities, :through => :activity_artist_ships

end
