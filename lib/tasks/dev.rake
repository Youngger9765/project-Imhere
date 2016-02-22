namespace :dev do

  task :clean_user_headshot => :environment do
    users = User.all
    
    users.each do |user|
      user.head_shot = nil
      user.save!
    end
  end
end