namespace :db do
  desc "Fill database with sample data"
  task :populate => :environment do
    Rake::Task['db:reset'].invoke
    admin = User.create!(:name => "Admin User",
                         :email => "hh@eclille.org",
                         :password => "foobar",
                         :password_confirmation => "foobar")
    admin.toggle!(:admin)
    99.times do |n|
      name  = Faker::Name.name
      email = "eleve-#{n+1}@eclille.org"
      password  = "password"
      User.create!(:name => name,
                   :email => email,
                   :password => password,
                   :password_confirmation => password)
    end
    User.all(:limit => 15).each do |user|
      user.create_player(:nickname => Faker::Name.first_name)
    end
    10.times do
      User.all(:limit => 15).each do |user|
        if user.player
          user.player.tournaments.create!(:title => Faker::Name.last_name<<"'s tournament")
        end
      end
    end

  end 
end