require 'spec_helper'
require 'app/user/create_user'

describe App::User::CreateUser do
  it 'creates a user and outputs with success yielding the new user' do
    user_repository = double('user_repository')
    allow(user_repository).to receive(:create).with(name: 'Me').and_return('The new user')

    create_user = App::User::CreateUser.new(user_repository: user_repository)

    create_user.call(name: 'Me') do |result|
      result.success do |user|
        expect(user).to eq('The new user')
      end
    end
  end
end
