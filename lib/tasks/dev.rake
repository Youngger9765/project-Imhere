namespace :dev do

  task :clean_user_headshot => :environment do
    users = User.all
    
    users.each do |user|
      user.head_shot = nil
      user.save!
    end
  end

  task :fill_user_lottery_ships_data => :environment do 
    
    UserLotteryShip.all.each do |ship|
      
      if ship.user_name.nil?
        ship.user_name = ship.user.name
        ship.save     
      end

      if ship.user_address.nil?
        ship.user_address = ship.user.address
        ship.save 
      end

      if ship.user_phone_number.nil?
        ship.user_phone_number = ship.user.phone_number
        ship.save 
      end

    end
  end
end