require 'spec_helper'

describe Resource do
  let(:resource) { FactoryGirl.create(:resource) }

  subject { resource }

  it { should respond_to(:name)}
  it { should respond_to(:subject)}
  it { should respond_to(:format) }
  it { should respond_to(:description) }
  it { should respond_to(:cost) }
  it { should respond_to(:cost_type)}
  it { should respond_to(:provider) }
  it { should respond_to(:url) }

  it { should be_valid }

  describe "when name is not present" do
    before { resource.name = " " }
    it { should_not be_valid }
  end
  
  describe "when subject is not present" do
    before { resource.subject = " " }
    it { should_not be_valid }
  end
  
  describe "when format is not present" do
    before { resource.format = " " }
    it { should_not be_valid }
  end

  describe "when description is not present" do
    before { resource.description = " " }
    it { should_not be_valid }
  end
  
  describe "when cost is not present" do
    before { resource.cost = " " }
    it { should_not be_valid }
  end

  describe "when cost is not an integer" do
    before { resource.cost = "foobar" }
    it { should_not be_valid }
  end

  describe "when cost_type is not present" do
    before { resource.cost_type = " " }
    it { should_not be_valid }
  end

  describe "when provider is not present" do
    before { resource.provider = " " }
    it { should_not be_valid }
  end

  describe "when url is not present" do
    before { resource.url = " " }
    it { should_not be_valid }
  end

  describe "when cost is a float" do
    before { resource.cost = 3.14159 }
    it { should_not be_valid }
  end

  describe "when cost is a negative" do
    before { resource.cost = -3.14159 }
    it { should_not be_valid }
  end

  describe "when url format is invalid" do
    it "should be invalid" do
        addresses = %w[test@test.com www.beerly? hello http:google.com http://ww3,gear.io]
        addresses.each do |invalid_address|
          resource.url = invalid_address
          expect(resource).not_to be_valid
        end
    end
  end

  describe "when resource name is already taken" do
    it "should not be valid" do 
      resource_two = FactoryGirl.create(:resource_two)
      resource = FactoryGirl.build(:resource, name: "example2")
      expect(resource).to be_invalid
    end
  end

  describe "when resource url is already taken" do
    it "should not be valid" do 
      resource_two = FactoryGirl.create(:resource_two)
      resource = FactoryGirl.build(:resource, url: "www.example2.com")
      expect(resource).to be_invalid
    end
  end


end
