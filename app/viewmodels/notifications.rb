class Notifications
  def initialize
    @messages = []
  end

  def messages
    @messages.clone
  end

  def has_messages?
    messages.length > 0
  end

  def <<(message)
    @messages << message.to_s
  end
end
