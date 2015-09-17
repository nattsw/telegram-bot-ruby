require 'rubygems'
require 'telegram/bot'
require_relative 'helper'
include Helper

token = ENV['GEEKCAMP_BOT_TOKEN']
my_id = ENV['TELEGRAM_ID']

Telegram::Bot::Client.run(token) do |bot|
  bot.listen do |message|
    next if message.text.nil?

    command = command(message.text)
    content = content(message.text)
    sender = message.from.first_name

    if is_reply?(message)
      command = get_command_from_reply(message)
      content = message.text
    end

    case command
    when 'pm','pm@GeekcampBot'
      if content.nil?
        get_reply(bot, message)
      else
        bot.api.send_message(chat_id: my_id, text: "#{sender}: #{content}")
      end
    when 'am','am@GeekcampBot'
      if content.nil?
        get_reply(bot, message)
      else
        bot.api.send_message(chat_id: my_id, text: "Anonymous: #{content}")
      end
    else
    end
  end
end

