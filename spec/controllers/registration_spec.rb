require 'spec_helper'

describe UsersController do
  describe 'registering a user' do
    it 'should check if the form is complete' do
    end
    describe 'after incomplete form' do
      it 'should redirect user back to registration page' do
      end
      it 'should highlight the incomplete fields' do
      end
      it 'should say \'Please fill required fields\'' do
      end
    end
    it 'should check if username exists' do
    end
    describe 'after preexisting username in username field' do
      it 'should redirect user back to registration page' do
      end
      it 'should highlight the username field' do
      end
      it 'should say \'Username already exists\'' do
      end
    end
    it 'should check if email exists' do
    end
    describe 'after preexisting email in email field' do
      it 'should redirect user back to registration page' do
      end
      it 'should highlight the email field' do
      end
      it 'should say \'Email already exists\'' do
      end
    end
    it 'should check if password and confirm password match' do
    end
    describe 'after passwords do not match' do
      it 'should redirect user back to registration page' do
      end
      it 'should highlight the confirm password field' do
      end
      it 'should say \'Passwords don\'t match\'' do
      end
    end
    it 'should create user' do
    end
    describe 'after successful registration' do
      it 'should redirect user to registration acknowledgement page' do
      end 
      it 'should display \'Send a reminder today!\'' do
      end
    end
  end
end  

      
    