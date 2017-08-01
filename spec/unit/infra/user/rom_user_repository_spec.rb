require 'spec_helper'
require 'infra/user/rom_user_repository'

describe Infra::User::ROMUserRepository do
  let(:user_repository) { Infra::User::ROMUserRepository.new }

  describe '#get_all' do
    context 'when there are users on the database' do
      before { create(:user, name: 'Me', email: 'me@email.com') }

      it 'return persisted users' do
        users = user_repository.get_all

        expect(users.size).to eq 1
        expect(users[0].name).to eq 'Me'
        expect(users[0].email).to eq 'me@email.com'
      end
    end

    context 'when there are no users on the database' do
      it 'returns an empty array' do
        users = user_repository.get_all

        expect(users.size).to eq 0
      end
    end
  end

  describe '#get_by_id' do
    context 'when user with given id exists' do
      it 'returns the user' do
        user_id = create(:user, name: 'Me', email: 'me@email.com').id

        user = user_repository.get_by_id(user_id)

        expect(user.name).to eq 'Me'
        expect(user.email).to eq 'me@email.com'
      end
    end

    context 'when user with given id does not exist' do
      it 'raises UserNotFound error' do
        expect {
          user_repository.get_by_id(0)
        }.to raise_error(user_repository.class::UserNotFound, '0')
      end
    end
  end

  describe '#create' do
    it 'creates a user' do
      expect {
        user_repository.create(name: 'Me', email: 'me@example.com')
      }.to change { user_repository.count }.by(1)
    end

    it 'returns the new user' do
      user = user_repository.create(name: 'Me', email: 'me@example.com')

      expect(user.id).to be_truthy
      expect(user.name).to eq 'Me'
      expect(user.email).to eq 'me@example.com'
    end
  end

  describe '#count' do
    it 'returns the quantity of users on the database' do
      2.times { create(:user) }

      expect(user_repository.count).to eq 2
    end
  end
end
