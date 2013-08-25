require "spec_helper"

describe UserMailer do
  describe "password_reset" do

    it "renders the headers" do
      mail.subject.should eq("Password Reset")
      mail.to.should eq(user.email)
      mail.from.should eq("code-dojo@sharklasers.com")
    end
  end
end
