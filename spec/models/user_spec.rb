require 'spec_helper'

describe User do

  before(:each) do
    @attr = {:name => 'Aman', :email => 'aman@aman.com', :password => 'password', :password_confirmation => 'password'}
  end

  it 'should create a new user' do
    User.create!(@attr).should be_valid
  end

  it 'should require a name' do
    User.new(@attr.merge(:name => '')).should_not be_valid
  end

  it 'should require a email' do
    User.new(@attr.merge(:email => '')).should_not be_valid
  end

  it 'should reject long names' do
    long_name = 'a' * 51
    User.new(@attr.merge(:name => long_name)).should_not be_valid
  end

  it 'should accept valid emails' do
    addresses = %w[user@foo.com USER@foo.bar.org first.last@foo.jp]
    addresses.each do |address|
      User.new(@attr.merge(:email => address)).should be_valid
    end
  end

  it 'should not accept valid emails' do
    addresses = %w[user@foo,com user_at_foo.org example.user@foo]
    addresses.each do |address|
      User.new(@attr.merge(:email => address)).should_not be_valid
    end
  end

  it 'should reject duplicate emails' do
    User.create(@attr)
    User.new(@attr).should_not be_valid
  end

  it 'should reject duplicate upper case email address' do
    uppercase_email = @attr[:email].upcase
    User.create!(@attr.merge(:email => uppercase_email))
    User.new(@attr).should_not be_valid
  end

  describe "passwords" do
    before(:each) do
      @user = User.new(@attr)
    end

    it 'should have password attribute' do
      @user.should respond_to :password
    end

    it 'should have a password confirmation attribute' do
      @user.should respond_to :password_confirmation
    end
  end

  describe "Password Validations" do

    it 'should require a password' do
      User.new(@attr.merge(:password => "", :password_confirmation => "")).should_not be_valid
    end

    it 'should require a matching password confirmation' do
      User.new(@attr.merge(:password_confirmation => "invalid")).should_not be_valid
    end

    it 'should reject short passwords' do
      short = 'a' * 5
      hash = @attr.merge(:password => short, :password_confirmation => short)
      User.new(hash).should_not be_valid
    end

    it 'should reject long passwords' do
      long = 'a' * 41
      hash = @attr.merge(:password => long, :password_confirmation => long)
      User.new(hash).should_not be_valid
    end

  end

  describe "password encryption" do
    before(:each) do
      @user = User.create!(@attr)
    end

    it 'should have encrypted password attribute' do
      @user.should respond_to :encrypted_password
    end

    it 'should set the encrypted password attribute' do
      @user.encrypted_password.should_not be_blank
    end

    it 'should have a salt' do
      @user.should respond_to :salt
    end

    describe "has_password?" do
      it 'should exist' do
        @user.should respond_to :has_password?
      end

      it 'should return true if passwords match' do
        @user.has_password?(@attr[:password]).should be_true
      end

      it 'should return false in case of password mismatch' do
        @user.has_password?('invalid').should be_false
      end
    end

    describe "authenticate method" do
      it 'should exist' do
        User.should respond_to :authenticate
      end

      it 'should return nil on email/password mismatch' do
        User.authenticate(@attr[:email], "wrong password").should be_nil
      end

      it 'should return nil for email address with no user' do
        User.authenticate("some@email.com", @attr[:password]).should be_nil
      end

      it 'should return correct user on email/password match' do
        User.authenticate(@attr[:email], @attr[:password]).should == @user
      end
    end
  end

  describe "micropost associations" do
    before(:each) do
      @user = FactoryGirl.create(:user)
      @mp1 = FactoryGirl.create(:micropost, :user => @user, :created_at => 1.days.ago)
      @mp2 = FactoryGirl.create(:micropost, :user => @user)
    end

    it 'should have a micropost attribute' do
      @user.should respond_to(:microposts)
    end

    it 'should have right microposts in the right order' do
      @user.microposts.should == [@mp2, @mp1]
    end

    it 'should destroy microposts with user' do
      @user.destroy
      [@mp1, @mp2].each { |m| Micropost.find_by_id(m.id).should be_nil }
    end
  end
end
