require 'rails_helper'

RSpec.describe Event, type: :system do
  it '/events/:idページを表示' do
    event = FactoryBot.create(:event)
    visit event_path(event)

    has_text?(event.name)
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

  it '/events/newページを表示' do
    sign_in_as(FactoryBot.create(:user))
    visit new_event_path
    has_text?('イベント作成')
    has_text?('名前')
    has_field?('#event_name')
    has_text?('場所')
    has_field?('#event_place')
    has_text?('開始時刻')
    has_field?('#event_start_at_1i')
    has_field?('#event_start_at_2i')
    has_field?('#event_start_at_3i')
    has_field?('#event_start_at_4i')
    has_field?('#event_start_at_5i')
    has_text?('終了時刻')
    has_field?('#event_end_at_1i')
    has_field?('#event_end_at_2i')
    has_field?('#event_end_at_3i')
    has_field?('#event_end_at_4i')
    has_field?('#event_end_at_5i')
    has_text?('内容')
    has_field?('#event_content')
    has_button?('登録する')
    button = find_button '登録する'
    expect(button['type']).to eq 'submit'
  end
end