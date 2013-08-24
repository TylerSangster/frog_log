require 'spec_helper'

describe Interest do

  let(:resource) { FactoryGirl.create(:resource) }
  let(:user) { FactoryGirl.create(:user) }
  let(:interest) { user.interests.build(resource_id: resource.id) }

  subject { interest }

  it { should be_valid }

  describe "interest methods" do
    it { should respond_to(:user) }
    it { should respond_to(:resource) }
    its(:user) { should eq user }
    its(:resource) { should eq resource }
  end

  describe "when user id is not present" do
    before { interest.user_id = nil }
    it { should_not be_valid }
  end

  describe "when resource id is not present" do
    before { interest.resource_id = nil }
    it { should_not be_valid }
  end
 
end