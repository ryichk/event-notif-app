# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Welcome Page', type: :system do
  it '/ページを表示' do
    visit root_path

    expect(page).to have_selector 'h1', text: 'イベント一覧'
  end

  it '/ページで未来のイベントが表示され、過去のイベントが非表示であること' do
    future_event = FactoryBot.create(:event, start_at: Time.zone.now + 3.days)
    past_event = FactoryBot.create(:event, start_at: Time.zone.now)

    travel_to Time.zone.now + 1.day do
      visit root_path
      has_text?(future_event.name)
      has_no_text?(past_event.name)
    end
  end
end
