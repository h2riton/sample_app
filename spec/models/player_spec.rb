require 'spec_helper'

describe Player do

  before(:each) do
    @user = Factory(:user)
    @attr = { :content => "Riton" }
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
end