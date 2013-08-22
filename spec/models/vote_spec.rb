require 'spec_helper'

describe Vote do

  let(:reviewer) { FactoryGirl.create(:user) }
  let(:review)   { FactoryGirl.create(:review, user: reviewer) }
  let(:voter)    { FactoryGirl.create(:user_two) }
  let(:vote)     { FactoryGirl.create(:vote, user: voter, review: review) }

  subject { vote }
  it { should be_valid }
  it { should respond_to(:review) }
  it { should respond_to(:user) }
  it { should respond_to(:kind) }

  describe "when user id is not present" do
    before { vote.user_id = nil }
    it { should_not be_valid }
  end

  describe "when review id is not present" do
    before { vote.review_id = nil }
    it { should_not be_valid }
  end

  describe "when vote kind is not present" do
    before { vote.kind = nil }
    it { should_not be_valid }
  end

  describe "when vote kind is not up or down" do
    before { vote.kind = "not up or down" }
    it { should_not be_valid }
  end
end
