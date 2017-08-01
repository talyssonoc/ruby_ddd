require 'spec_helper'
require 'app/user/get_user'

describe App::User::GetUser do
  describe 'when user exists on the repository' do
    it 'outputs with success yielding the user with the given id' do
      user_repository = double('user_repository')
      allow(user_repository).to receive(:get_by_id).with(123).and_return(name: 'Me')

      get_user = App::User::GetUser.new(user_repository: user_repository)

      get_user.call(user_id: 123) do |result|
        result.success do |user|
          expect(user).to eq(name: 'Me')
        end
      end
    end
  end

  describe 'when user does not exist on the repository' do
    it 'outputs with not_found yielding the error' do
      user_repository_class = Class.new do
        UserNotFound = Class.new(StandardError)
      end

      user_repository = user_repository_class.new

      allow(user_repository).to receive(:get_by_id).with(123).and_raise(user_repository_class::UserNotFound)

      get_user = App::User::GetUser.new(user_repository: user_repository)

      get_user.call(user_id: 123) do |result|
        result.not_found do |error|
          expect(error).to be_a(user_repository_class::UserNotFound)
        end
      end
    end
  end
end
