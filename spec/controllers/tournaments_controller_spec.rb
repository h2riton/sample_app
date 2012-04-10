require 'spec_helper'

describe TournamentsController do
  render_views

  describe "access control" do

    it "should deny access to 'create'" do
      post :create
      response.should redirect_to(signin_path)
    end

    it "should deny access to 'destroy'" do
      delete :destroy, :id => 1
      response.should redirect_to(signin_path)
    end
  end
  
  describe "POST 'create'" do

    before(:each) do
      @user = test_sign_in(Factory(:user))
      @player = Factory(:player, :user => @user)
    end

    describe "failure" do

      before(:each) do
        @attr = { :title => "" }
      end

      it "should not create a tournament" do
        lambda do
          post :create, :tournament => @attr
        end.should_not change(Tournament, :count)
      end

      it "should render the home page" do
        post :create, :tournament => @attr
        response.should render_template('pages/home')
      end
    end

    describe "success" do

      before(:each) do
        @attr = { :title => "Challenge ECLille" }
      end

      it "should create a tournament" do
        lambda do
          post :create, :tournament => @attr
        end.should change(Tournament, :count).by(1)
      end

      it "should redirect to the home page" do
        post :create, :tournament => @attr
        response.should redirect_to(root_path)
      end

      it "should have a flash message" do
        post :create, :tournament => @attr
        flash[:success].should =~ /tournament created/i
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
        @tournament = Factory(:tournament, :player => @player)
      end

      it "should deny access" do
        delete :destroy, :id => @tournament
        response.should redirect_to(root_path)
      end
    end

    describe "for an authorized user" do

      before(:each) do
        @user = test_sign_in(Factory(:user))
        @player = Factory(:player, :user => @user)
        @tournament = Factory(:tournament, :player => @player)
      end

      it "should destroy the tournament" do
        lambda do 
          delete :destroy, :id => @tournament
        end.should change(Tournament, :count).by(-1)
      end
    end
  end
end