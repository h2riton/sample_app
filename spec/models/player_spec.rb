require 'spec_helper'

describe Player do
  
  before(:each) do
    @user = Factory(:user)
    @attr = { :nickname => "Riton" }
  end
  
  it "should create a new instance given valid attributes" do
    @user.player.create!(@attr)
  end
  
  describe "user associations" do
    
    before(:each) do
      @player = @user.player.create(@attr)
    end
    
    it "should have a user attribute" do
      @player.should respond_to(:user)
    end
    
    it "should have the right associated user" do
      @player.user_id.should == @user.id
      @player.user should == @user
    end
  end
    
end
