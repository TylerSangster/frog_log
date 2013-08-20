require 'spec_helper'

describe "ResourcePages" do

  subject { page }
  describe "new Resource page" do
    let(:user) { FactoryGirl.create(:user) }
    before do
      login user
      visit new_resource_path
    end

    it { should have_title('New Resource') }

    describe "fill out form incorrectly" do
      it "should not create a Resource" do
        expect { click_button "Create Resource" }.not_to change(Resource, :count)
      end

      describe "after submission" do
          before { click_button "Create Resource" }

          it { should have_title('New Resource') }
          it { should have_content('error') }
      end
    end

    describe "fill out New Resource form" do
      before do
        fill_in "Name",            with: "Ruby on Rails"
        fill_in "Subject",         with: "Rails with ruby"
        fill_in "Format",          with: "book"
        fill_in "Description",     with: "Great book to learn ruby,rails and testings"
        fill_in "Cost",            with: 1999

        fill_in "Cost Type",       with: "one time"
        fill_in "Provider",        with: "Mike Hartl"
        fill_in "URL",             with: "http://ruby.railstutorial.org/ruby-on-rails-tutorial-book"

      end

      it "should increment resource count" do
        expect { click_button "Create Resource" }.to change(Resource,:count).by(1)
      end

      describe "should display thank you message" do
        before { click_button "Create Resource";}
        let(:resource) { FactoryGirl.build(:resource) }

        it { should have_title("Show Resource") }
        
        it { should have_selector('div.alert.alert-success', text: 'Thank you') }
      end
    end
  end#new resource

  describe "edit" do
    let(:resource) { FactoryGirl.create(:resource) }
    before do 
      visit edit_resource_path(resource)
    end

    describe "page" do
      it { should have_content("Edit Resource") }
      it { should have_title("Edit Resource") }
    end

    describe "with invalid information" do
      let(:new_name)  { " " }
      before do 
        fill_in "Name",               with: new_name
        click_button "Save Changes"
      
      end

      it { should have_title("Edit Resource") }
      it { should have_content("error") }
    end

    describe "with valid information" do
      let(:new_name)  { "Rails for Zombies" }
      let(:new_description)  { "Learn rails with zombies" }
      let(:new_format) { "online tutorial" }
      let(:new_cost)  { 1799 }
      let(:new_cost_type) { "per Month" }
      before do
        fill_in "Name",               with: new_name
        fill_in "Description",        with: new_description
        fill_in "Format",             with: new_format
        fill_in "Cost",               with: new_cost
        fill_in "Cost Type",   with: new_cost_type
        click_button "Save Changes"
      end


      it { should have_title("Show Resource") }
      it { should have_selector('div.alert.alert-success') }

      specify { expect(resource.reload.name).to  eq new_name }
      specify { expect(resource.reload.description).to  eq new_description }
      specify { expect(resource.reload.format).to  eq new_format }
      specify { expect(resource.reload.cost).to  eq new_cost }
      specify { expect(resource.reload.cost_type).to  eq new_cost_type }
    end
  end#edit resource

  describe "index" do
    let!(:resource) { FactoryGirl.create(:resource) }
    let!(:resource_two) { FactoryGirl.create(:resource_two) }
    let!(:admin_user) { FactoryGirl.create(:admin_user) }
    before(:each) do
      visit resources_path
    end

    it { should have_title('All Resources') }
    it { should have_content('All Resources') }

    it { should have_content(resource.name) }
    it { should have_content(resource.subject) }
    it { should have_content(resource.format) }

    it { should have_content(resource.description) }
    it { should have_content(resource.cost) }
    it { should have_content(resource.cost_type) }
    it { should have_content(resource.provider) }
    it { should have_content(resource.url) }
    
    it { should have_link('edit', href: edit_resource_path(resource)) }

    describe "delete links" do
      it { should_not have_link('delete') }
      
      describe "as admin user" do
        before { login admin_user; visit resources_path }
        it { should have_link('delete', href: resource_path(Resource.first)) }

        it "should be able to delete resource" do
          expect do
            click_link('delete', match: :first)
          end.to change(User, :count).by(-1)
        end

      end
    end
  end#index
end

