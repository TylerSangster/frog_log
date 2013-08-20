namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    make_users
    make_reviews
  end
    
  def make_users
    User.create!(first_name: "Najwa",
                 last_name: "Azer", 
                 email: "na.jwa.azer@gmail.com",
                 password: "foobar",
                 password_confirmation: "foobar",
                 admin: true)
    
    99.times do |n|
      first_name  = Faker::Name.first_name
      last_name  = Faker::Name.last_name
      email = "example-#{n+1}@example.com"
      password  = "password#{n}"
      User.create!(first_name: first_name,
                   last_name: last_name,
                   email: email,
                   password: password,
                   password_confirmation: password)
    end
  end

  def make_reviews
    users = User.all(limit: 6)
    5.times do
      score = 3
      title = Faker::Lorem.sentence(2)
      content = "a "*200
      users.each { |user| user.reviews.create!(score: score, title: title, content: content) }
    end
  end
end