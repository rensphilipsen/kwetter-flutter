import 'package:flutter/material.dart';
import 'package:pusher_flutter/pusher_flutter.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map _latestMessage;
  PusherError _lastError;
  PusherConnectionState _connectionState;
  PusherFlutter pusher =
  new PusherFlutter("e2bb6e9dcc94497b2e16", cluster: "eu");

  @override
  initState() {
    super.initState();
    pusher.onConnectivityChanged.listen((state) {
      setState(() {
        _connectionState = state;
        if (state == PusherConnectionState.connected) {
          _lastError = null;
        }
      });
    });
    pusher.onError.listen((err) => _lastError = err);
    _connectionState = PusherConnectionState.disconnected;
    this.connect();
  }

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      home: new Scaffold(
          appBar: new AppBar(
            title: new Text('Pusher example app.'),
          ),
          body: new Column(
            children: <Widget>[
              new Row(
                children: <Widget>[
                  new Text('Latest message ${_latestMessage.toString()}')
                ],
                mainAxisAlignment: MainAxisAlignment.center,
              ),
              new MaterialButton(onPressed: connect, child: new Text("Connect"))
            ],
          )),
    );
  }

  void connect() {

  }

  void disconnect() {
    pusher.unsubscribe("new_kweet");
    pusher.disconnect();
  }
}
