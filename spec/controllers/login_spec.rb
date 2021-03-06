require 'spec_helper'

describe LoginController do

  describe 'login page' do
    it 'should render the login page' do
      get :index
      response.should render_template 'index'
    end
    it 'should redirect and flash if already logged in' do
      session[:userid] = 'notnil'
      get :index
      response.should redirect_to welcome_path
      flash[:notice].should include 'You\'re already logged in!'
    end
  end
  
  describe 'logout page' do
    it 'should log user out and flash' do
      get :logout
      flash[:notice].should include 'Logged out successfully'
      response.should redirect_to welcome_path
    end
    it 'should log user out and redirect' do
      get :logout
      response.should redirect_to welcome_path
    end
    it 'should log user out and destroy session' do
      get :logout
      session[:userid].should be_nil
    end
  end
  
  describe 'forgot password' do
    before :each do
      @params = {:email => 'test'}
    end
    it 'should render lostpassword page' do
      get :forgot_password
      response.should render_template "lostpassword"
    end
    it 'should check if able to reset password' do
      User.should_receive(:forgot_password).with(@params[:email])
      post :send_password, @params
    end
    it 'should flash and redirect if password reset' do
      User.stub(:forgot_password).and_return(true)
      post :send_password, @params
      flash[:notice].should include 'Password successfully sent'
      response.should redirect_to welcome_path
    end
    it 'should flash and redirect if password could not be reset' do
      User.stub(:forgot_password).and_return(false)
      post :send_password, @params
      flash[:error].length.should be > 0
      response.should redirect_to forgot_path
    end
  end
  
  describe 'log in a user' do
    before :each do
      @user = mock()
      @userid = 5
      @username = 'testuser'
      @user.stub(:name).and_return @username
      @user.stub(:id).and_return @userid
      @params = {:user => {:name => 'testuser', :email => 'asdf@asdf.com', :password => 'abc'}}
    end
    
    it 'should call valid_user' do
      User.should_receive(:valid_user)
      post :login, @params
    end
    
    it 'should flash error if invalid credentials' do
      User.stub(:valid_user)
      post :login, @params
      flash[:error].should include 'Email and password combination do not match, try again!'
    end
    
    it 'should redirect to login page again if invalid credentials' do
      User.stub(:valid_user)
      post :login, @params
      response.should redirect_to login_path
    end
    
        
    it 'should set session error if valid credentials' do
      User.stub(:valid_user).and_return @user
      @user.stub(:is_admin)
      post :login, @params
      session[:userid].should eq @userid
    end
    
    it 'should redirect to welcome page if valid credentials' do
      User.should_receive(:valid_user).and_return @user
      @user.stub(:is_admin)
      post :login, @params
      response.should redirect_to send_path 
      flash[:notice].should eq 'Welcome, <strong>' + @user.name + '</strong>!'
    end

    it 'should redirect to admin panel if user is an admin' do
    	User.stub(:valid_user).and_return @user
    	@user.should_receive(:is_admin).and_return true
    	post :login, @params
    	response.should redirect_to admin_path
		end
  end
end  

      
    
