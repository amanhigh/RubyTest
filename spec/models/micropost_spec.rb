require 'spec_helper'

describe Micropost do
  before(:each) do
    @user = FactoryGirl.create(:user)
    @attr = {:content => 'Test'}
  end

  it 'should create it with valid attribs' do
    @user.microposts.create!(@attr)
  end

  describe "User associations" do
    before(:each) do
      @micropost = @user.microposts.create!(@attr)
    end

    it 'should have a user attribute' do
      @micropost.should respond_to(:user)
    end

    it 'should have right assocated user' do
      @micropost.user_id.should == @user.id
      @micropost.user.should == @user
    end
  end

  describe "validations" do
    it 'should require nonblank content' do
      @user.microposts.build(:content => '        ').should_not be_valid
    end

    it 'should not be too long' do
      @user.microposts.build(:content => 'a' * 141).should_not be_valid
    end
  end
end
