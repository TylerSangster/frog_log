require 'spec_helper'

describe User do

	let(:user) { FactoryGirl.create(:user) }

	subject { user }

	it { should respond_to(:first_name)}
	it { should respond_to(:last_name)}
	it { should respond_to(:email) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
	it { should respond_to(:password_digest)}


  it { should respond_to(:authenticate) }
  it { should respond_to(:admin) } 
  it { should_not be_admin }

  it { should respond_to(:reviews) }

  it { should respond_to(:votes) }
  it { should respond_to(:vote!) }
  it { should respond_to(:has_voted?) }
  it { should respond_to(:has_upvoted?) }
  it { should respond_to(:has_downvoted?) }

  it { should be_valid }

  describe "with admin attribute set to 'true'" do
    before do
      user.save!
      user.toggle!(:admin)
    end
    it { should be_admin }
  end

  describe "when first name is not present" do
		before { user.first_name = " " }
		it { should_not be_valid }
	end
	
  describe "when last name is not present" do
		before { user.last_name = " " }
		it { should_not be_valid }
	end
	
	describe "when email is not present" do
		before { user.email = " " }
		it { should_not be_valid }
	end
	   
  describe "when password is not present" do
    before { user.password = " "; user.password_confirmation = " " }
		it { should_not be_valid }
  end

	describe "when email format is invalid" do
  	it "should be invalid" do
  		addresses = %w[user@foo,com user_at_foo.org example.user@foo. foo@bar_baz.com foo@bar+baz.com]
  		addresses.each do |invalid_address|
    		user.email = invalid_address
    		expect(user).not_to be_valid
  		end
  	end
	end

	describe "when email format is valid" do
  	it "should be valid" do
  		addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
  		addresses.each do |valid_address|
    		user.email = valid_address
    		expect(user).to be_valid
  		end
  	end
	end

	describe "when email address is already taken" do
  	it "should not be valid" do 
  		user_two = FactoryGirl.create(:user_two)
      user = FactoryGirl.build(:user, email: "najwa.azer@gmail.com")
      expect(user).to be_invalid
  	end
	end

	describe "when different case email address is already taken" do
  	it "should be invalid" do 
  		user_two = FactoryGirl.create(:user_two)
      user = FactoryGirl.build(:user, email: "NAJWA.AZER@gmail.com")
      expect(user).to be_invalid
  	end
	end

  describe "when password doesn't match confirmation" do
    before { user.password_confirmation = "mismatch" }
    it { should be_invalid }
  end
  
  describe "when password is too short" do
    before { user.password = user.password_confirmation = "a" * 5 }
    it { should be_invalid }
  end

  describe "voting" do 
    let(:reviewer) { FactoryGirl.create(:user_two) }
    let(:review)   { FactoryGirl.create(:review, user: reviewer) }
    
    it "should change vote counts if up" do
      expect { user.vote!(review, "up") }.to change(review.upvotes, :count).by(1)
      expect { user.vote!(review, "up") }.not_to change(review.downvotes, :count)
    end

    it "should change vote counts if down" do
      expect { user.vote!(review, "down") }.to change(review.downvotes, :count).by(1)
      expect { user.vote!(review, "down") }.not_to change(review.upvotes, :count)
    end

    describe "should change voted flags if up" do 
      before { user.vote!(review, "up") }
      it { should have_voted(review) }
      it { should have_upvoted(review) }
      it { should_not have_downvoted(review) }

      describe "followed by up" do
        before { user.vote!(review, "up") }
        it { should have_voted(review) }
        it { should have_upvoted(review) }
        it { should_not have_downvoted(review) }
        
        it "should not change vote" do
          expect { user.vote!(review, "up") }.not_to change(review.upvotes, :count)
        end
      end
    end

    describe "should change voted flags if down" do 
      before { user.vote!(review, "down") }
      it { should have_voted(review) }
      it { should_not have_upvoted(review) }
      it { should have_downvoted(review) }

      describe "followed by up" do
        before { user.vote!(review, "up") }
        it { should have_voted(review) }
        it { should have_upvoted(review) }
        it { should_not have_downvoted(review) }
      end
    end

    describe "does not allow user to vote on own review" do
      before { reviewer.vote!(review, "up") }
      subject { reviewer }
        it { should_not have_voted(review) }
        it { should_not have_upvoted(review) }
        it { should_not have_downvoted(review) }
      end


      # describe "voting on own review" do
      #   before { }
  end

end