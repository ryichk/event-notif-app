# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Event, type: :model do
  let(:event) { FactoryBot.create(:event) }

  context 'validations' do
    it 'nameの文字数が50より大きい場合validation error' do
      name = 'a' * 51
      event = FactoryBot.build(:event, name:)
      event.valid?
      expect(event.errors[:name]).not_to be_empty
    end

    it 'nameが空白の場合validation error' do
      event = FactoryBot.build(:event, name: '')
      event.valid?
      expect(event.errors[:name]).not_to be_empty
    end

    it 'placeの文字数が100より大きい場合validation error' do
      place = 'a' * 101
      event = FactoryBot.build(:event, place:)
      event.valid?
      expect(event.errors[:place]).not_to be_empty
    end

    it 'placeが空白の場合validation error' do
      event = FactoryBot.build(:event, place: '')
      event.valid?
      expect(event.errors[:place]).not_to be_empty
    end

    it 'contentの文字数が2000より大きい場合validation error' do
      content = 'a' * 2001
      event = FactoryBot.build(:event, content:)
      event.valid?
      expect(event.errors[:content]).not_to be_empty
    end

    it 'contentが空白の場合validation error' do
      event = FactoryBot.build(:event, content: '')
      event.valid?
      expect(event.errors[:content]).not_to be_empty
    end

    it 'start_at_should_be_before_end_at validation OK' do
      start_at = rand(1..30).days.from_now
      end_at = start_at + rand(1..30).hours
      event = FactoryBot.build(:event, start_at:, end_at:)
      event.valid?
      expect(event.valid?).to eq true
    end

    it 'start_at_should_be_before_end_at validation error' do
      start_at = rand(1..30).days.from_now
      end_at = start_at - rand(1..30).hours
      event = FactoryBot.build(:event, start_at:, end_at:)
      event.valid?
      expect(event.errors[:start_at]).not_to be_empty
    end
  end

  context 'instance methods' do
    it 'created_by? owner_idと引数のidが同じ時' do
      expect(event.created_by?(event.owner)).to eq true
    end

    it 'created_by? owner_idと引数のidが異なるとき' do
      another_user = FactoryBot.create(:user)
      expect(event.created_by?(another_user)).to eq false
    end

    it 'created_by?の引数がnilの時' do
      expect(event.created_by?(nil)).to eq false
    end
  end
end
