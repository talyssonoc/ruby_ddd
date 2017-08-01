require 'spec_helper'
require 'app/user/get_all_users'

describe App::User::GetAllUsers do
  it 'outputs with success yielding all users' do
    user_repository = double('user_repository')
    allow(user_repository).to receive(:get_all).and_return(['user1', 'user2'])

    get_all_users = App::User::GetAllUsers.new(user_repository: user_repository)

    get_all_users.call do |result|
      result.success do |users|
        expect(users).to eq(['user1', 'user2'])
      end
    end
  end
end
