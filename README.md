## Ruby Example: Client-Server with TCP

Let’s build a simple client-server system in Ruby using TCP sockets to simulate a card game interaction (e.g., playing a card and getting a response). This mirrors how games might handle real-time communication.

**How to Run:**

1.  Save the server code as `server.rb` and run it: `ruby server.rb`.
2.  Save the client code as `client.rb` and run it in a separate terminal: `ruby client.rb`.

**Output:**

* **Server:** "Server started on port 12345", "Client connected", "Client disconnected".
* **Client:** "Connected to server", "Server says: Card Fireball played, dealt 3 damage", "Disconnected".

**Explanation:**

* **Server:** Uses `TCPServer` to listen on port 12345. It accepts client connections, reads messages (e.g., "PLAY:Fireball:3"), processes them, and sends a response.
* **Client:** Uses `TCPSocket` to connect, sends a command, and prints the server’s reply.
* **Communication:** Raw TCP—no HTTP overhead. Messages are simple strings, parsed manually, mimicking how games send compact packets (e.g., binary in real systems).

This is a basic example—real games use binary formats, handle multiple clients better (e.g., with select or event loops), and add error checking, but it shows the directness of TCP.


## Additions and Explanations

**1. Detailed Comments**

I’ve added inline comments to explain what each line does, making it clear why we use `TCPServer`, `TCPSocket`, or threads. This helps someone unfamiliar with sockets understand the flow.

**2. Error Handling**

* **Server:** Catches connection errors and client disconnects, printing useful messages. The `Interrupt` rescue handles `Ctrl+C` to stop the server cleanly.
* **Client:** Handles connection refusal (e.g., if the server isn’t running) with a friendly message, avoiding cryptic stack traces.

**3. Game-Like Feature**

Added a shared `@opponent_health` variable on the server to simulate a game state, like an opponent’s health in `Hearthstone`. Each card play reduces it, showing how servers maintain authoritative state.

**4. Interactivity**

The client plays two cards sequentially with a `sleep` to mimic turn-based play. This makes it feel more like a game and shows how messages flow back and forth.

**5. Key Concepts Highlighted**

* **Sockets:** `TCPServer` and `TCPSocket` are Ruby’s built-in tools for TCP communication. They’re like a phone line—once connected, you can send and receive messages.
* **Threads:** The server uses `Thread.new` to handle multiple clients at once (though this is basic—real games use event loops or frameworks like EventMachine for scale).
* **Message Format:** The "PLAY:card_name:damage" format is a simple protocol, like how games send compact packets (e.g., binary in real systems).

**6. What’s Happening?**

* **Client:** Sends a command (e.g., "PLAY:Fireball:3") to the server, waits for a response, and prints it.
* **Server:** Listens for connections, reads the command, updates the game state (health), and replies with the result.
* **Network:** Data travels over TCP, ensuring every message arrives in order—crucial for games where sequence matters (e.g., card plays).

**Tips for Newbies**

* **Why TCP?:** It’s reliable—nothing gets lost or jumbled. UDP (faster but less reliable) would need more code to handle lost packets, which we’ve skipped here.
* **Real Games:** This is simplified. Games use binary data (not strings), encryption, and handle thousands of players with load balancers.
* **Try It Out:** Run the server, then open multiple terminals to run `client.rb`—each will affect the same opponent health, showing shared state!
* **Next Steps:** Add a loop in the client to keep sending commands, or make the server broadcast health to all connected clients (mimicking multiplayer).

**How This Relates to Games**

* **MTG Arena/Hearthstone:** The server tracks match state (e.g., board, health) and validates moves, sending updates to both players’ clients via TCP or WebSockets.
* **RuneScape/WoW:** Similar, but with UDP for real-time movement and more complex state (e.g., world map, NPCs). The server ensures everyone sees the same game world.

This example is a stepping stone—it’s not production-ready but shows the core idea of client-server communication in games.