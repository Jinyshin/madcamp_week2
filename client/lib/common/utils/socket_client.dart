import 'package:socket_io_client/socket_io_client.dart';

class SocketClient {
  late Socket socket;
  static SocketClient? _instance;

  SocketClient._internal() {
    socket = io(
        'http://143.248.191.30:3000',
        OptionBuilder()
            .setTransports(['websocket'])
            .disableAutoConnect()
            .build());

    socket.onConnect((_) {
      print('플러터 소켓 연결됨');
    });

    socket.onDisconnect((_) => print('플러터 소켓 끊김'));

    socket.on('event', (data) => print(data));

    socket.connect();
  }

  static SocketClient get instance {
    _instance ??= SocketClient._internal();
    return _instance!;
  }
}
