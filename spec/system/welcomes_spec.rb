require 'rails_helper'

RSpec.describe 'Welcome Page', type: :system do
  it '/ページを表示' do
    visit root_path

    expect(page).to have_selector 'h1', text: 'イベント一覧'
  end

  it '/ページで未来のイベントが表示され、過去のイベントが非表示であること' do
    future_event = FactoryBot.create(:event, start_at: Time.zone.now + 3.day)
    past_event = FactoryBot.create(:event, start_at: Time.zone.now)

    travel_to Time.zone.now + 1.day do
      visit root_path
      assert_selector 'h5', text: future_event.name
      assert_no_selector 'h5', text: past_event.name
    end
  end
end
