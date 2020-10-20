require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    describe 'password validation' do
      it 'must be created with a matching password and password confirmation field' do
        @user = User.new(name: 'fatima', email: 'fatima@htomail.com', password: 'matching', password_confirmation: 'matching')
        expect(@user.save).to be true
      end
      it 'must be not be created with a non-matching password and password confirmation field' do
        @user = User.new(name: 'fatima', email: 'fatima@htomail.com', password: 'helloIamnot', password_confirmation: 'matching')
        expect(@user.save).to be false
      end
    end

    describe 'email uniqueness' do
      it 'must ensure that emails are unique' do
        @user1 = User.create(name: 'fatima', email: 'fatima@htomail.com', password: 'matching', password_confirmation: 'matching')
        @user2 = User.new(name: 'fatima', email: 'FATIMA@htomail.com', password: 'matching', password_confirmation: 'matching')
        expect(@user2.save).to be false
      end
    end

    describe 'email presence' do
      it 'saves user when email is present' do
        @user = User.new(name: 'fatima', email: 'fatima@htomail.com', password: 'matching', password_confirmation: 'matching')
        expect(@user.save).to be true
      end

      it 'does not save user when email is not present' do
        @user = User.new(name: 'fatima', password: 'matching', password_confirmation: 'matching')
        expect(@user.save).to be false
      end
    end

    describe 'name presence' do
      it 'saves user when name is present' do
        @user = User.create(name: 'fatima', email: 'fatima@htomail.com', password: 'matching', password_confirmation: 'matching')
        expect(@user.save).to be true
      end
      it 'does not save user when name is not present' do
        @user = User.create(email: 'fatima@htomail.com', password: 'matching', password_confirmation: 'matching')
        expect(@user.save).to be false
      end
    end

    describe 'password min length' do
      it 'must save a user who has a password with a min length of 6 characters' do
        @user = User.new(name: 'fatima', email: 'fatima@htomail.com', password: 'matching', password_confirmation: 'matching')
        expect(@user.save).to be true
      end
      it 'must not save a user who does not have a password with a min length of 6 characters' do
        @user = User.new(name: 'fatima', email: 'FATIMA@htomail.com', password: 'ma', password_confirmation: 'ma')
        expect(@user.save).to be false
      end
    end
  end

  describe '.authenticate_with_credentials' do
    it 'must return nil if user does not exist' do
      @user = User.authenticate_with_credentials('hello@world.com', '12345')
      expect(@user).to be nil
    end

    it 'must return nil if authentification failed' do
      @user = User.create(name: 'fatima', email: 'fatima@hotmail.com', password: 'matching', password_confirmation: 'matching')
      @test = User.authenticate_with_credentials('fatima@hotmail.com', 'helloworld')
      expect(@test).to be nil
    end
    it 'must return user object if authentification successful' do
      @user = User.create(name: 'fatima', email: 'fatima@hotmail.com', password: 'matching', password_confirmation: 'matching')
      @test = User.authenticate_with_credentials('    fatima@hotmail.COM', 'matching')
      expect(@test.name).to eq 'fatima'
    end
  end
end