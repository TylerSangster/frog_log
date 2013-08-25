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
    interested_users = User.all[31..100]
    20.times do |n|      
      subject_list = ["Rails, Ruby", "RSpec, Capybara, Rails", "HTML5, CSS3", "jQuery, AJAX, Rails", "Coffescript"]
      format_list = ["book, screencast", "book, exercises", "blog post", "interactive tutorial, exercises, video", "podcast"]
      provider_list = ["Michael Hartl", "Code School", "Codecademy", "Treehouse", "Pragmatic Programmers"]
      name = Faker::Lorem.sentence(1)
      description = ["Baba laalaa doo-doo dada laa goo. Goo caca gaa ya dada ya da ya gaga widdle doo dada gaagaa. Ga bed.",
                     "Gaa da widdle laalaa doodoo ya doo quick-quick gaagaa gaagaa laa doodoo googoo. Doo goo dada dada y.",
                     "Laalaa gaa dada gaa doodoo sleepy-bye goo ga gaaga.",
                     "Gaa laa laalaa laalaa laalaa doo goo boo-boo. Dada dada sissy doodoo ga googoo mama.",
                     "Da gaagaa laa doo yaya doodoo laalaa gaga yaya yaya laa googoo."
                    ]      
      cost = [900, 0, 1999, 2500, 3500]
      cost_type = ["monthly", "one-time", "weekly", "yearly", "bi-weekly"]
      url = "www.google#{n}.com"
      resource = Resource.create!(name: name, 
                                  description: description[rand(4)], 
                                  cost: cost[rand(4)], 
                                  cost_type: cost_type[rand(4)], 
                                  url: url, 
                                  subject_list: subject_list[rand(4)], 
                                  format_list: format_list[rand(4)], 
                                  provider_list: provider_list[rand(4)] )
      interested_users.each do |interested_user|
          resource.interests.create!(user: interested_user) if rand(10)>4
      end
    end
  end

  def make_reviews
    users = User.all
    reviewers = users[1..10]
    voters    = users[11..30] 
    reviewers.each do |reviewer| 
      15.times do |n|
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
