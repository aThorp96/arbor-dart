import 'dart:io';
import 'dart:async';
import 'client.dart';

void main(List<String> args) async {
    String url;
    int port;
    if (args.length > 0) {
        List<String> arg = args[0].split(":");
        url = arg[0];
        if (arg.length < 2) {
            print("Forgot to include port number");
            exit(1);
        } else {
            port = int.parse(arg[1]);
        }
    } else {
        print("Must append execution with conneciton url of the form <address>:<port number>");
        exit(1);
    }
    print("Attempting a connection to $url on port $port");
    Client client = await startClient("username", url, port);
}
