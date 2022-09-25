require 'rails_helper'

RSpec.describe Event, type: :system do
  it '/events/:idページを表示' do
    event = FactoryBot.create(:event)
    visit event_path(event)

    expect(page).to have_selector 'h1', text: event.name
    has_text?('イベント内容')
    has_text?(event.content)
    has_text?('開催時間')
    has_text?('開催場所')
    has_text?(event.place)
    has_text?('主催者')
    has_text?("@#{event.owner.name}")

    has_text?('イベント編集')
    has_text?('イベント削除')
    has_text?('参加する')
    has_text?('参加者')
  end
end