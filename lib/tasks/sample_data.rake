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
    users = User.all
    reviewers = users[1..10]
    voters    = users[11..30] 
    reviewers.each do |reviewer| 
      5.times do |n|
        score = rand(4)+1
        title = Faker::Lorem.sentence(3)
        content = [ "You hate me; you want to kill me! Well, go on! Kill me! KILL ME! Sorry, checking all the water in this area; there's an escaped fish. Saving the world with meals on wheels. They're not aliens, they're Earth…liens!", 
                  "I am the last of my species, and I know how that weighs on the heart so don't lie to me! All I've got to do is pass as an ordinary human being. Simple. What could possibly go wrong? I'm the Doctor. Well, they call me the Doctor. I don't know why. I call me the Doctor too. I still don't know why. They're not aliens, they're Earth…liens!",
                  "You know when grown-ups tell you 'everything's going to be fine' and you think they're probably lying to make you feel better? No, I'll fix it. I'm good at fixing rot. Call me the Rotmeister. No, I'm the Doctor. Don't call me the Rotmeister. Aw, you're all Mr. Grumpy Face today. I'm the Doctor. Well, they call me the Doctor. I don't know why. I call me the Doctor too. I still don't know why. Saving the world with meals on wheels.",
                  "All I've got to do is pass as an ordinary human being. Simple. What could possibly go wrong? You hate me; you want to kill me! Well, go on! Kill me! KILL ME! Father Christmas. Santa Claus. Or as I've always known him: Jeff.",
                  "All I've got to do is pass as an ordinary human being. Simple. What could possibly go wrong? You've swallowed a planet! You've swallowed a planet! Did I mention we have comfy chairs? Stop talking, brain thinking. Hush."
                  ]
        review = reviewer.reviews.create!(score: score, title: title, content: content[rand(4)], resource_id: n+1) 
        voters.each do |voter|
          vote_type = ["up", "down"]
          review.votes.create!(user: voter, kind: vote_type[rand(0..1)])
        end
      end
    end
  end
end