import 'package:client/data/datasources/socket_client.dart';

class SocketService {
  final _socketClient = SocketClient.instance.socket!;

  void createRoom(String nickname) {
    if (nickname.isNotEmpty) {
      print(nickname);

      _socketClient.emit('creatRoom', {
        'nickname': nickname,
      });
    }
  }
}
