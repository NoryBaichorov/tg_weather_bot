# frozen_string_literal: true

Rails.application.routes.draw do
  post '/telegram_webhook', to: 'telegram_webhooks#receive'
end
