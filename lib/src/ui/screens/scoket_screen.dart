import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

class SocketScreen extends StatefulWidget {
  const SocketScreen({Key? key}) : super(key: key);

  @override
  State<SocketScreen> createState() => _SocketScreenState();
}

class _SocketScreenState extends State<SocketScreen> {
  final url = 'wss://kings-cards-v2.herokuapp.com';
  late final io.Socket socket;

  @override
  void initState() {
    super.initState();
    connect();
  }

  void connect() {
    socket = io.io(url);
    socket.onConnect((_) {
      print('connect');
      socket.emit('msg', 'test');
      log('status: ${socket.connected}');
    });
    log('status: ${socket.connected}');
    socket.on('new message', (data) => log(data));
    socket.onDisconnect((_) => log('disconnect'));
    socket.on('fromServer', (_) => log(_));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          socket.connected.toString(),
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: Colors.white,
                fontSize: 24.sp,
              ),
        ),
      ),
    );
  }
}
