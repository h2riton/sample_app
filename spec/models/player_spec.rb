require 'spec_helper'

describe Player do

  before(:each) do
    @user = Factory(:user)
    @attr = { :nickname => "Riton" }
  end

  it "should set a player given valid attribute" do
    @user.create_player(@attr)
  end

  describe "user associations" do

    before(:each) do
      @player = @user.create_player(@attr)
    end

    it "should have a user attribute" do
      @player.should respond_to(:user)
    end

    it "should have the right associated user" do
      @player.user_id.should == @user.id
      @player.user.should == @user
    end
  end
  
  describe "validations" do

    it "should require a user id" do
      Player.new(@attr).should_not be_valid
    end

    it "should require nonblank nickname" do
      @user.create_player(:nickname => "  ").should_not be_valid
    end

    it "should reject long content" do
      @user.create_player(:nickname => "a" * 141).should_not be_valid
    end
  end  
  
  describe "tournament associations" do

    before(:each) do
      @player = @user.create_player(@attr)
      @tm1 = Factory(:tournament, :player => @player, :created_at => 1.day.ago)
      @tm2 = Factory(:tournament, :player => @player, :created_at => 1.hour.ago)
    end

    it "should have a microposts attribute" do
      @player.should respond_to(:tournaments)
    end
    
    it "should have the right microposts in the right order" do
      @player.tournaments.should == [@tm2, @tm1]
    end
  end
  
end