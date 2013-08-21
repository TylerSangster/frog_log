require 'spec_helper'

describe "Review pages" do

  subject { page }

  let(:user) { FactoryGirl.create(:user) }
  let(:other_user) { FactoryGirl.create(:user_two) }
  let(:admin_user) { FactoryGirl.create(:admin_user) }

  before { login user }

  describe "review creation" do
    before { visit new_review_path }

    describe "with invalid information" do
    
      it "should not create a review" do
        expect { click_button "Create review" }.not_to change(Review, :count)
      end
      
      describe "error messages" do
        before { click_button "Create review" }
        it { should have_content('error') }
      end
    end

    describe "with valid information" do

      before do 
        review = FactoryGirl.create(:review, user: user)
        fill_in 'review_score',   with: review.score
        fill_in 'review_title', with: review.title
        fill_in 'review_content', with: review.content
      end

      it "should create a review" do
        expect { click_button "Create review" }.to change(Review, :count).by(1)
      end
    end
  end

  describe "review destruction" do
    let!(:review) { FactoryGirl.create(:review, user: user) }
  
    describe "as correct user" do
      before { visit review_path(review.id) }

      it "should delete a review" do
      expect { click_link "delete" }.to change(Review, :count).by(-1)
      end
    end
  end

  describe "review show page" do
    let(:review) { FactoryGirl.create(:review, user: user) }
    
      before { visit review_path(review) }
      it { should have_content(review.title) }
      it { should have_content(review.score) }
      it { should have_content(review.content) }
      it { should have_content(review.user.first_name) }
      it { should have_content(review.user.last_name) }
      it { should have_title("#{review.title}, #{review.score}") }
      it { should have_link('edit'), href: edit_review_path(review) }
      it { should have_link('delete'), href: review_path(review) }

      describe "for another user's review" do
        let(:other_user_review) { FactoryGirl.create(:review, user: other_user) }
        before { visit review_path(other_user_review) }
        it { should_not have_link('edit') }
        it { should_not have_link('delete') }
      end

      describe "as an admin" do
        before { login admin_user; visit review_path(review)}
        it { should have_link('edit'), href: edit_review_path(review) }
        it { should have_link('delete'), href: review_path(review) }
      end
    end


  describe "edit" do
    let(:review) { FactoryGirl.create(:review, user: user) }
    before do 
      login user
      visit edit_review_path(review) 
    end

    describe "page" do
      it { should have_content("Edit your review") }
      it { should have_title("Edit your review") }
    end

    describe "with invalid information" do
      before do 
        fill_in "Title",       with: "a"*5
        click_button "Save Changes"
      end

      it { should have_title("Edit your review") }
      it { should have_content("error") }
    end

    describe "with valid information" do
      let(:new_title)  { "This is an edited review" }
      let(:new_score)  { 2 }
      let(:new_content) { "Edited review. Edited review. Edited review. Edited review. Edited review. Edited review. Edited review. Edited review. " }
      before do
        fill_in "Title",       with: new_title
        fill_in "Score",       with: new_score
        fill_in "Content",     with: new_content
        click_button "Save Changes"
      end

      it { should have_title("#{new_title}, #{new_score}") }
      it { should have_selector('div.alert.alert-success') }

      specify { expect(review.reload.title).to  eq new_title }
      specify { expect(review.reload.score).to  eq new_score }
      specify { expect(review.reload.content).to eq new_content }
    end
  end#edit

end