require 'telegram/bot'
require 'net/http'
require 'json'
require_relative 'bot.rb'

class Motivate
  URL = 'https://type.fit/api/quotes'

  class << self
    def make_the_request
      uri = URI(URL)
      response = Net::HTTP.get(uri)
      response = JSON.parse(response, object_class: OpenStruct)
      motivational_quote = response.sample
  
      motivational_quote.text + ' - ' + motivational_quote.author
    end
  end
end