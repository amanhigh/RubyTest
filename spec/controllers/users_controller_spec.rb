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

    it 'should the right URL' do
      visit user_path(@user)
      page.should have_selector('td>a', :text => user_path(@user), :href => user_path(@user))
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

  describe "POST 'create'" do

    describe "failure" do
      before(:each) do
        @attr = {:name => "", :email => "", :password => "", :password_confirmation => ""}
      end

      it 'should have the right title' do
        post :create, :user => @attr
        response.body.should have_selector('title', :text => "Sign up")
      end

      it 'should render the new page' do
        post :create, :user => @attr
        response.should render_template('new')
      end

      it 'should not create the user' do
        lambda do
          post :create, :user => @attr
        end.should_not change(User, :count)
      end

    end

    describe "success" do
      before(:each) do
        @attr = FactoryGirl.attributes_for(:user)
      end

      it 'should create a user' do
        lambda do
          post :create, :user => @attr
        end.should change(User, :count).by(1)
      end

      it 'should redirect to user show page' do
        post :create, :user => @attr
        response.should redirect_to(user_path(assigns(:user)))
      end

      it 'should have a welcome message' do
        post :create, :user => @attr
        flash[:success].should =~ /welcome to the sample app!/i
      end

      it 'should sign the user in' do
        post :create, :user => @attr
        controller.should be_signed_in
      end
    end
  end

  describe "GET 'edit'" do
    before(:each) do
      @user = FactoryGirl.create(:user)
      test_sign_in @user
    end

    it 'should be successfull' do
      get :edit, :id => @user
      response.should be_success
    end

    it 'should have right title' do
      visit edit_user_path(@user)
      page.should have_selector('title', :text => 'Edit user')
    end

    it 'should have gravatar edit link' do
      visit edit_user_path(@user)
      page.should have_selector('a[href="http://gravatar.com/email"]', :text => 'Change')
    end
  end

  describe "PUT 'update'" do
    before(:each) do
      @user = FactoryGirl.create(:user)
      test_sign_in @user
    end

    describe "failure" do
      before(:each) do
        @attr = {:name => "", :email => "", :password => "", :password_confirmation => ""}
      end

      it 'should render the edit page' do
        put :update, :id => @user, :user => @attr
        response.should render_template('edit')
      end

      it 'should have right title' do
        visit edit_user_path(:id => @user, :user => @attr)
        page.should have_selector('title', :text => 'Edit user')
      end
    end

    describe "success" do
      before(:each) do
        @attr = {:name => "New Name", :email => "new@email.com", :password => "newpassword", :password_confirmation => "newpassword"}
      end

      it 'should change user attributes' do
        put :update, :id => @user, :user => @attr
        user = assigns(:user)
        @user.reload
        @user.name.should == user.name
        @user.email.should == user.email
        @user.encrypted_password.should == user.encrypted_password
      end

      it 'should have flash message' do
        put :update, :id => @user, :user => @attr
        flash[:success].should =~ /updated/i
      end

    end
  end

end
