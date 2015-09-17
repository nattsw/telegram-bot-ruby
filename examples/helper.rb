module Helper
  def is_command?(text)
    text.start_with?("/")
  end

  def is_reply?(message)
    message.reply_to_message!=nil
  end

  def command(text)
    command = nil
    command = (text[/\/(.+) (.+)/,1] || text[/\/(.+)/,1].strip) if is_command?(text)
    command
  end

  def content(text)
    text[/\/(.+) (.+)/,2]
  end

  def get_reply(bot, message)
    bot.api.send_message(chat_id: message.chat.id, text: message.text, reply_to_message_id: message.message_id ,reply_markup: reply)
  end

  def reply
    Telegram::Bot::Types::ForceReply.new(force_reply: true, selective: true)
  end

  def get_command_from_reply(message)
    command = nil
    command = command(message.reply_to_message.text) if is_reply?(message)
    command
  end
end
