class Message
  attr_reader :message

  def initialize
  end

  def scan(target)
    "Scanned #{target.name} - HP: #{target.curr_hp}/#{target.max_hp}"
  end

end
