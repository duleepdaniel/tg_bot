require 'telegram/bot'
require 'net/http'
require 'json'
require_relative 'bot.rb'

class Book
  GOOGLE_BOOK_API_KEY = ENV['GOOGLE_API_KEY']

  class << self
    def make_the_request(**args)
      url = "https://www.googleapis.com/books/v1/volumes?q=intitle:#{args[:title]}+inauthor:#{args[:author]}}&key=#{GOOGLE_BOOK_API_KEY}"
      uri = URI(url)
      response = Net::HTTP.get(uri)
      response = JSON.parse(response, object_class: OpenStruct)
      parse_response(response)
    end

    def parse_response(result)
      binding.pry
      # result.items.map{|item| item.dig(:volumeInfo, :categories)}.flatten
      return "OopS - Sorry I could not find any book" if result.totalItems == 0



    end
  end
end