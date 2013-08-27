require 'spec_helper'
class PasswordResetsControllerTest < ActionController::TestCase

  describe "Authentication" do
    let(:user) { FactoryGirl.create(:user) }
    subject { page }
    describe "edit page" do
      it { should have_content('password') }
      it { should have_content('password_confirmation') }
  end

    describe "new" do
      let(:user) { FactoryGirl.create(:user) }
      before do
        fill_in "Email",  with: user.email.upcase
        click_button "Reset Password"
    end
  end
end