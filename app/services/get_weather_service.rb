# frozen_string_literal: true

require 'httparty'
require 'json'

class GetWeatherService
  include HTTParty
  
  BASE_URL = 'http://api.weatherapi.com/v1/current.json'
  API_KEY = 'afb8dc11b88a4176ae7130437241310'

  def self.get_geocoding_data(city)
    begin
      response = HTTParty.get("#{BASE_URL}?q=#{city}&key=#{API_KEY}&aqi=no", timeout: 10)

      if response.success?
        data = JSON.parse(response.body)
        if data.any?
          data
        else
          puts "Нет данных"
        end
      else
        puts "Ошибка при запросе: #{response.code} #{response.message}"
      end
    rescue Net::OpenTimeout, Net::ReadTimeout
      puts "Запрос превысил время ожидания."
    rescue SocketError => e
      puts "Ошибка соединения: #{e.message}"
    rescue JSON::ParserError => e
      puts "Ошибка при парсинге ответа: #{e.message}"
    rescue StandardError => e
      puts "Произошла непредвиденная ошибка: #{e.message}"
    end
  end
end
