# frozen_string_literal: true

require 'telegram/bot'

class TelegramBotService
  def initialize(bot)
    @bot = bot
  end

  def handle_update(update)
    case update
    when Telegram::Bot::Types::Update
      handle_message(update&.message)
    end
  end

  def handle_message(message)
    case message.text
    when '/start'
      send_message(message.chat.id, "Добро пожаловать, #{message.from.first_name}! Я - бот, который подскажет прогноз погоды. Если хочешь получить текущие погодные условия, отправь мне '/weather' ")
    when '/weather'
      send_message(message.chat.id, 'Укажи город, в котором хочешь узнать погоду на латинице (пр. Moscow или Sochi)')
    else
      response = GetWeatherService.get_geocoding_data(message.text)

      temp = response['current']['temp_c']
      feelslike = response['current']['feelslike_c']
      humidity = response['current']['humidity']
      city = response['location']['name']

      send_message(message.chat.id,
      "Погода в городе #{city}:\nТемпература: #{temp} °C\nОщущается как: #{feelslike} °C\nВлажность: #{humidity} f")
    end
  end

  def send_message(chat_id, text)
    @bot.api.send_message(chat_id:, text:)
  end
end
