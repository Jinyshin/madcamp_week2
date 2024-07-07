import 'dart:async';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

void main() {
  runApp(const MyApp());
}

// STEP1: Stream setup
class StreamSocket {
  final _socketResponse = StreamController<String>();

  void Function(String) get addResponse => _socketResponse.sink.add;

  Stream<String> get getResponse => _socketResponse.stream;

  void dispose() {
    _socketResponse.close();
  }
}

StreamSocket streamSocket = StreamSocket();

//STEP2: Add this function in main function in main.dart file and add incoming data to the stream
void connectAndListen() {
  IO.Socket socket = IO.io('http://localhost:3000',
      IO.OptionBuilder().setTransports(['websocket']).build());

  socket.onConnect((_) {
    print('소켓 연결됨');
    socket.emit('msg', 'test');
  });

  // When an event received from server, data is added to the stream
  socket.on('event', (data) {
    streamSocket.addResponse(data);
  });
  socket.onDisconnect((_) => print('소켓 끊김'));
}

// Main app
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Initiate the connection and listen to the socket
    connectAndListen();
    print("외 연결 안되냐....");

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Socket.IO Stream Example'),
        ),
        body: const Center(
          child: BuildWithSocketStream(),
        ),
      ),
    );
  }
}

// Step3: Build widgets with StreamBuilder
class BuildWithSocketStream extends StatelessWidget {
  const BuildWithSocketStream({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder(
        stream: streamSocket.getResponse,
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (!snapshot.hasData) {
            return const Text('No data');
          } else {
            return Text('Received: ${snapshot.data}');
          }
        },
      ),
    );
  }
}


// import 'package:client/common/const/app_colors.dart';
// import 'package:client/ui/view/create_room_screen.dart';
// import 'package:client/ui/view/game_tictactoe_screen.dart';
// import 'package:client/ui/view/home_screen.dart';
// import 'package:client/ui/view/join_room_screen.dart';
// import 'package:flutter/material.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData.dark().copyWith(
//         scaffoldBackgroundColor: AppColors.bgColor,
//       ),
//       routes: {
//         MainMenuScreen.routeName: (context) => const MainMenuScreen(),
//         JoinRoomScreen.routeName: (context) => const JoinRoomScreen(),
//         CreateRoomScreen.routeName: (context) => const CreateRoomScreen(),
//         GameTicTacToeScreen.routeName: (context) => const GameTicTacToeScreen()
//       },
//       initialRoute: MainMenuScreen.routeName,
//     );
//   }
// }
