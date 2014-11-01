require 'rails_helper'
require 'spec_helper'

RSpec.describe User, :type => :model do

  before(:each) do
    @test_user = build(:user)
  end

  describe "CRUD actions" do
    before(:each) do
      User.delete_all
    end

    describe "create a new user" do
      it "should be successful when using a unique email" do
        @test_user.save
        expect(User.first).to eq @test_user
      end

      it "should not save duplicate emails" do
        duplicate_user = @test_user.dup
        @test_user.save
        duplicate_user.save
        expect(User.count).to be 1
      end

      it "should not save incorrect email types" do
        bad_emails = ["cheese", "123@123", "abc@sdg.com.com"]
        bad_emails.each do |email|
          @test_user.email = "cheese"
          @test_user.save
          expect(User.count).to be 0
        end
      end
    end

    describe "read users" do
      it "should show an individual user" do
        @test_user.save
        expect(User.where(id: @test_user.id)).not_to be_empty
      end

      it "should show all users" do
        users = create_list(:user, 3)

        expect(User.all.count).to be 3
        users.each do |user|
          expect(User.where(id: user.id)).not_to be_empty
        end
      end
    end
  end
end