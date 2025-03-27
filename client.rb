require 'socket'

# Simple game client
class GameClient
  def initialize(host, port)
    @socket = TCPSocket.new(host, port)
    puts "Connected to server"
  end

  def play_card(card_name, damage)
    # Send message to server
    @socket.puts "PLAY:#{card_name}:#{damage}"

    # Receive server response
    response = @socket.gets.chomp
    puts "Server says: #{response}"
  end

  def close
    @socket.close
    puts "Disconnected"
  end
end

# Connect to server and play a card
client = GameClient.new('localhost', 12345)
client.play_card("Fireball", 3)
client.close