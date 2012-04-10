require 'spec_helper'

describe Tournament do

  before(:each) do
    @user = Factory(:user)
    @player = Factory(:player, :user => @user)
    @attr = { :title => "Tournoi ECLille" }
  end

  it "should create a new instance given valid attributes" do
    @user.player.tournaments.create!(@attr)
  end

  describe "user associations" do

    before(:each) do
      @tournament = @user.player.tournaments.create(@attr)
    end

    it "should have a user attribute" do
      @tournament.should respond_to(:player)
    end

    it "should have the right associated user" do
      @tournament.player_id.should == @player.id
      @tournament.player.should == @player
    end
  end
  
  describe "validations" do

    it "should require a player id" do
      Tournament.new(@attr).should_not be_valid
    end

    it "should require nonblank title" do
      @player.tournaments.build(:title => "  ").should_not be_valid
    end

    it "should reject long title" do
      @player.tournaments.build(:content => "a" * 40).should_not be_valid
    end
  end
end