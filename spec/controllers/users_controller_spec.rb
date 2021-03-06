require 'spec_helper'

describe UsersController do
  let(:users_controller) { UsersController.new }
  let(:user) { double User }
  let (:errors) { [:errors] }

  describe 'public methods' do
    let(:user_params) { ActionController::Parameters.new }

    before(:each) do
      allow(users_controller).to receive(:flash).and_return Hash.new
      allow(users_controller).to receive :login_with_session
      allow(users_controller).to receive :redirect_to
      allow(users_controller).to receive :render
      allow(users_controller).to receive(:user_params).and_return user_params
      allow(users_controller).to receive(:set_user).and_return user
      users_controller.instance_variable_set :@user, user
      allow(errors).to receive(:full_messages).and_return ['']
    end

    describe '#create' do
      it 'creates a user from valid params' do
        expect(User).to receive(:new).with(user_params).and_return user
        expect(user).to receive(:save).and_return true
        users_controller.create
      end

      it 'handles invalid params' do
        expect(User).to receive(:new).with(user_params).and_return user
        expect(user).to receive(:save).and_return false
        users_controller.create
      end
    end

    describe '#show' do
      it 'sets the current user' do
        users_controller.show
      end
    end

    describe '#update' do
      before(:each) do
        allow(user).to receive :update
      end

      it 'updates the model' do
        expect(user).to receive :update
        users_controller.update
      end
    end

    describe '#destroy' do
      it 'destroys the user model' do
        expect(user).to receive :destroy
        users_controller.destroy
        expect(users_controller.flash[:info]).to_not be_nil
      end
    end

    describe '#index' do
      it 'orders all users by email' do
        expect(User).to receive(:order).with :email
        users_controller.index
      end
    end

    describe '#new' do
      it 'uses a new user' do
        expect(User).to receive :new
        users_controller.new
      end
    end

    describe '#edit' do
      it 'uses an existing user' do
        expect(users_controller).to receive :set_user
        users_controller.edit
      end
    end

    describe '#delete' do
      it 'uses the existing user' do
        expect(users_controller).to receive :set_user
        users_controller.delete
      end
    end
  end

  describe 'private methods' do
    let(:params) { ActionController::Parameters.new }

    before(:each) do
      allow(users_controller).to receive(:params).and_return params
      allow(params).to receive :permit!
    end

    describe '#set_user' do
      it 'finds the current user' do
        expect(User).to receive(:find_by).and_return user
        users_controller.send :set_user
      end
    end

    describe '#user_params' do
      it 'requires user' do
        expect(params).to receive(:require).with(:user).and_return params
        users_controller.send :user_params
      end
    end
  end
end
