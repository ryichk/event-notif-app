# frozen_string_literal: true

class EventsController < ApplicationController
  skip_before_action :authenticate, only: :show

  def new
    @event = current_user.created_events.build
  end

  def create
    @event = current_user.created_events.build(event_params)

    redirect_to @event, notice: 'イベント作成完了' if @event.save
  end

  def show
    @event = Event.find(params[:id])
    @ticket = current_user&.tickets&.find_by(event: @event)
    @tickets = @event&.tickets&.includes(:user)&.order(:created_at)
  end

  def edit
    @event = current_user&.created_events&.find(params[:id])
  end

  def update
    @event = current_user&.created_events&.find(params[:id])
    redirect_to @event, notice: '更新完了' if @event.update(event_params)
  end

  def destroy
    @event = current_user&.created_events&.find(params[:id])
    @event.destroy!
    redirect_to root_path, notice: '削除完了'
  end

  private

  def event_params
    params.require(:event).permit(
      :name, :place, :content, :start_at, :end_at, :image, :remove_image
    )
  end
end
