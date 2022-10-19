require 'telegram/bot'
require_relative 'motivate'

class Bot
  def initialize
    token = ENV['TG_BOT_TOKEN']

    Telegram::Bot::Client.run(token) do |bot|
      bot.listen do |message|
        case message.text.split(' ').first
        when '/start'
          text = <<~TEXT
            Hello, #{message.from.first_name}
            Welcome to Sugggest chat bot created by Duleep Panthagani, this bot can be used to suggest Books Based on Book's Author, Title and prompt Motivational Quotes at Random.

            Use:
            /start to start the bot,
            /motivate for a Motivational Quote
            /book to get book query options
            /stop to end the bot
          TEXT
          bot.api.send_message(chat_id: message.chat.id, text: text)
        when '/motivate'
          motivation = Motivate.make_the_request
          bot.api.send_message(chat_id: message.chat.id, text: motivation, date: message.date)
        when '/book'
          instructions = <<~TEXT
          If you need to search for the book by
          **author**: Use !author followed by the author name Eg: !author JK Rowling
          **title**: Use !title followed by the title Eg: !title Rich Dad Poor Dad
          TEXT
          bot.api.send_message(chat_id: message.chat.id, text: instructions, date: message.date)
        when '!author'
          bot.api.send_message(chat_id: message.chat.id, text: 'Using Author Book query', date: message.date)
        when '!title'
          bot.api.send_message(chat_id: message.chat.id, text: 'Using Title Book query', date: message.date)
        when '/motivate'
          motivation = Motivate.make_the_request
          bot.api.send_message(chat_id: message.chat.id, text: motivation, date: message.date)
        else
          bot.api.send_message(chat_id: message.chat.id,
                               text: "Invalid entry, #{message.from.first_name}, you need to use  /start,  /stop , /motivate or /book")
        end
      end
    end
  end
end
