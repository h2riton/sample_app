require 'spec_helper'

describe PlayersController do
render_views

  describe "access control" do
    
    it "should deny access to 'new'" do
      get :new
      response.should redirect_to(signin_path)
    end

    it "should deny access to 'create'" do
      post :create
      response.should redirect_to(signin_path)
    end

    it "should deny access to 'destroy'" do
      delete :destroy, :id => 1
      response.should redirect_to(signin_path)
    end
  end

  describe "GET 'new'" do
    
    before(:each) do
        @user = test_sign_in(Factory(:user))
    end
    
    describe "for users without a player" do
      
      it "should be successful" do
        get :new
        response.should be_success
      end
      
      it "should have the right title" do
        get :new
        response.should have_selector("title", :content => "Set player")
      end
    end
    
    describe "for users with a player" do
      
      before(:each) do
        @user.create_player(:nickname => "Riton")
      end
      
      it "should deny access" do
        get :new
        response.should redirect_to(user_path(@user))
      end
    end
    
  end
  
  describe "POST 'create'" do

    before(:each) do
      @user = test_sign_in(Factory(:user))
    end

    describe "failure" do

      before(:each) do
        @attr = { :nickname => "" }
      end

      it "should not create a player" do
        lambda do
          post :create, :player => @attr
        end.should_not change(Player, :count)
      end

      it "should render the user page" do
        post :create, :player => @attr
        response.should render_template('new')
      end
    end
    
    describe "success" do

      before(:each) do
        @attr = { :nickname => "Riton" }
      end

      it "should create a player" do
        lambda do
          post :create, :player => @attr
        end.should change(Player, :count).by(1)
      end

      it "should redirect to the user page" do
        post :create, :player => @attr
        response.should redirect_to(user_path(@user))
      end

      it "should have a flash message" do
        post :create, :player => @attr
        flash[:success].should =~ /player created/i
      end
    end
    
  end
  
  describe "GET 'edit'" do

    before(:each) do
      @user = Factory(:user)
      test_sign_in(@user)
      @player = Factory(:player, :user => @user)
    end

    it "should be successful" do
      get :edit, :id => @player
      response.should be_success
    end

    it "should have the right title" do
      get :edit, :id => @player
      response.should have_selector("title", :content => "Edit player")
    end
    
  end
  
  describe "PUT 'update'" do

    before(:each) do
      @user = Factory(:user)
      test_sign_in(@user)
      @player = Factory(:player, :user => @user)
    end

    describe "failure" do

      before(:each) do
        @attr = { :nickname => "" }
      end

      it "should render the 'edit' page" do
        put :update, :id => @player, :player => @attr
        response.should render_template('edit')
      end

      it "should have the right title" do
        put :update, :id => @player, :player => @attr
        response.should have_selector("title", :content => "Edit player")
      end
    end

    describe "success" do

      before(:each) do
        @attr = { :nickname => "Riton" }
      end

      it "should change the player's attributes" do
        put :update, :id => @player, :player => @attr
        @player.reload
        @player.nickname.should  == @attr[:nickname]
      end

      it "should redirect to the user show page" do
        put :update, :id => @player, :player => @attr
        response.should redirect_to(user_path(@user))
      end

      it "should have a flash message" do
        put :update, :id => @player, :player => @attr
        flash[:success].should =~ /updated/
      end
    end
  end
  
  describe "authentication of edit/update pages" do

    before(:each) do
      @user = Factory(:user)
      @player = Factory(:player, :user => @user)
    end

    describe "for non-signed-in users" do

      it "should deny access to 'edit'" do
        get :edit, :id => @user
        response.should redirect_to(signin_path)
      end

      it "should deny access to 'update'" do
        put :update, :id => @user, :user => {}
        response.should redirect_to(signin_path)
      end
    end
    
    describe "for signed-in users" do

      before(:each) do
        wrong_user = Factory(:user, :email => "user@example.net")
        test_sign_in(wrong_user)
      end

      it "should require matching users for 'edit'" do
        get :edit, :id => @player
        response.should redirect_to(root_path)
      end

      it "should require matching users for 'update'" do
        put :update, :id => @player, :user => {}
        response.should redirect_to(root_path)
      end
    end
    
  end
  
  describe "DELETE 'destroy'" do

    describe "for an unauthorized user" do

      before(:each) do
        @user = Factory(:user)
        wrong_user = Factory(:user, :email => Factory.next(:email))
        test_sign_in(wrong_user)
        @player = Factory(:player, :user => @user)
      end

      it "should deny access" do
        delete :destroy, :id => @player
        response.should redirect_to(root_path)
      end
    end

    describe "for an authorized user" do

      before(:each) do
        @user = test_sign_in(Factory(:user))
        @player = Factory(:player, :user => @user)
      end

      it "should destroy the player" do
        lambda do 
          delete :destroy, :id => @player
        end.should change(Player, :count).by(-1)
      end
    end
  end
  
end
