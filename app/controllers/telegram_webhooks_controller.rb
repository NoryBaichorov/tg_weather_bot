# frozen_string_literal: true

require 'telegram/bot'

class TelegramWebhooksController < ApplicationController
  TG_BOT_KEY = '8144023937:AAEEFONdMDSbE6CCVVucwhLG72ZfVcmhXjE'
  
  def receive
    bot = Telegram::Bot::Client.new(TG_BOT_KEY)

    update = Telegram::Bot::Types::Update.new(JSON.parse(request.body.read))

    TelegramBotService.new(bot).handle_update(update)

    head :ok
  rescue => e
    Rails.logger.error "Telegram webhook error: #{e.message}"
    head :ok
  end
end
