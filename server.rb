require 'socket'

# Simple game server
class GameServer
  def initialize(port)
    @server = TCPServer.new(port)
    puts "Server started on port #{port}"
  end

  def run
    loop do
      # Accept client connection
      client = @server.accept
      puts "Client connected"

      # Handle client in a thread
      Thread.new do
        begin
          # Read client message (e.g., "PLAY:Fireball:3")
          message = client.gets.chomp
          command, card, value = message.split(':')

          if command == "PLAY"
            response = "Card #{card} played, dealt #{value} damage"
            client.puts response
          else
            client.puts "Unknown command"
          end
        rescue => e
          puts "Error: #{e}"
        ensure
          client.close
          puts "Client disconnected"
        end
      end
    end
  end
end

# Start server on port 12345
server = GameServer.new(12345)
server.run