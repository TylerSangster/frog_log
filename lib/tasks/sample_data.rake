namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    make_users
    make_resources
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

  def make_resources
    5.times do |n|
      name = Faker::Lorem.sentence(1)
      subject = Faker::Lorem.sentence(1)
      format = "book"
      description = "I hate yogurt. It's just stuff with bits in. You know when grown-ups tell you 'everything's going to be fine' and you think they're probably lying to make you feel better? I'm the Doctor, I'm worse than everyone's aunt. *catches himself* And that is not how I'm introducing myself. All I've got to do is pass as an ordinary human being. Simple. What could possibly go wrong?"
      cost = 1999
      cost_type = "monthly"
      provider = "provider"
      url = "www.google#{n}.com"

      Resource.create!(name: name, subject: subject, format: format, description: description, cost: cost, cost_type: cost_type, provider: provider, url: url )
    end
  end

  def make_reviews
    users = User.all(limit: 6)
    5.times do
      i =1
      score = 3
      resource_id=i
      title = Faker::Lorem.sentence(2)
      content = "I hate yogurt. It's just stuff with bits in. You know when grown-ups tell you 'everything's going to be fine' and you think they're probably lying to make you feel better? I'm the Doctor, I'm worse than everyone's aunt. *catches himself* And that is not how I'm introducing myself. All I've got to do is pass as an ordinary human being. Simple. What could possibly go wrong?"
      users.each { |user| user.reviews.create!(score: score, title: title, content: content, resource_id: resource_id) }
      i=i+1
    end
  end
end