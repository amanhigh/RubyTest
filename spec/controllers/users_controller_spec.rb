require 'spec_helper'

describe UsersController do
  render_views

  describe "GET 'show'" do

    before(:each) do
      @user = FactoryGirl.create(:user)
    end

    it 'should be successfull' do
      get :show, :id => @user
      response.should be_success
    end

    it 'should find the right user' do
      get :show, :id => @user
      assigns(:user).should == @user
    end

    it 'should have right title' do
      visit user_path(@user)
      page.should have_selector('title', :text => @user.name)
    end

    it "should have user's name" do
      visit user_path(@user)
      page.should have_selector('h1', :text => @user.name)
    end

    it "should have profile image" do
      visit user_path(@user)
      page.should have_selector('h1>img', :class => "gravatar")
    end
  end

  describe "GET 'new'" do

    it "should be successfull" do
      visit '/users/new'
      response.should be_success
    end

    it 'should have the right title' do
      visit '/users/new'
      page.should have_selector('title', :text => 'Sign up')
    end

  end

end
