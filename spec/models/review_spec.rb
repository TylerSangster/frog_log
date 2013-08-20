require 'spec_helper'

describe Review do

  let(:user) { FactoryGirl.create(:user) }
  
  before { @review = user.reviews.build(score: 4, title: "a"*10, content: "c"*100) }

  subject { @review }

  it { should respond_to(:user_id)}
  it { should respond_to(:score)}
  it { should respond_to(:title) }
  it { should respond_to(:content) }
  its(:user) { should eq user }

  it { should be_valid }

  describe "no blank content" do
    before { @review.content = " " }
    it { should_not be_valid }
  end

  describe "content has length between 10 and 100" do
    before { @review.content= "ten" * 34 }
    it { should be_valid }
  end

  describe "content has min length of 100" do
    before { @review.content= "a"*99 }
    it { should_not be_valid }
  end

  describe "content has max length of 1000" do
    before { @review.content = "fail" * 251 }
    it { should_not be_valid }
  end

  describe "no blank title" do
    before { @review.title = " " }
    it { should_not be_valid }
  end

  describe "title has length between 10 and 100" do
    before { @review.title = "ten" * 4 }
    it { should be_valid }
  end

  describe "title has min length of 10" do
    before { @review.title = "a" * 9 }
    it { should_not be_valid }
  end

  describe "title has max length of 100" do
    before { @review.title = "fail" * 26 }
    it { should_not be_valid }
  end

  describe "score should not be a string" do
    before { @review.score = "four" }
    it { should_not be_valid }
  end

  describe "score should not be a decimal" do
    before { @review.score = 3.5 }
    it { should_not be_valid }
  end

  describe "score is min of 1" do
    before { @review.score = 0 }
    it { should_not be_valid }
  end

  describe "score is max of 5" do
    before { @review.score = 6 }
    it { should_not be_valid }
  end
end