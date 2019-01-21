import 'dart:io';
import 'dart:async';
import 'dart:convert';

class Client {

    Socket socket;
    var inputStream;

    void openConnection(String address, int port) async {
        socket = await  Socket.connect(address, port);
    }

}

Future<Client> startClient(String username, String address, int port) async {
    Client c = new Client();
    await c.openConnection(address, port);
    c.socket.listen((event) => handleIncoming(event)));
    return c;
}

String buffer = "";
/// handleIncoming uses the buffer to ensure JSONs are completely recieved before they're
/// decoded.
///
/// @param input: the raw byte data recieved over the TLS connection
void handleIncoming(List<int> input) {
    buffer = buffer + String.fromCharCodes(input);
    while (buffer.length > 0 && buffer.contains("\n")) {
        int messageEnd = buffer.indexOf("\n");
        String messageRaw = buffer.substring(0, messageEnd);
        buffer = buffer.substring(messageEnd + 1, buffer.length);
        print(messageRaw + "\n"); // Do something with complete JSON
    }
}


