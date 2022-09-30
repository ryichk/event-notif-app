# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Events', type: :request do
  describe 'DELETE /events/:id' do
    it '自ら作成したイベントは削除できる' do
      event_owner = FactoryBot.create(:user)
      event = FactoryBot.create(:event, owner: event_owner)
      sign_in_as event_owner

      count = Event.count
      delete event_path(event)
      expect(Event.count).to eq count - 1
    end

    it '他のユーザが作成したイベントは削除できない' do
      event_owner = FactoryBot.create(:user)
      event = FactoryBot.create(:event, owner: event_owner)

      sign_in_user = FactoryBot.create(:user)
      sign_in_as sign_in_user

      count = Event.count
      delete event_path(event)
      expect(Event.count).to eq count
    end
  end
end
