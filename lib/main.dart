// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart';

import 'env/env.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Arduino IOT Dashboard',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: const MyHomePage(title: 'Arduino IOT Connect Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Socket? socket;
  bool _connected = false;
  String? pressureFromCloud;

  bool _ledState = false;

  void connectToServer() {
    const snackBarSuccess = SnackBar(
      content: Text('You are connected to the SERVER'),
    );
    const snackBarFail = SnackBar(
      content: Text('Failed to connect'),
    );
    try {
      socket = io(Env.adr,
          OptionBuilder().setTransports(['websocket']).build());
      print("connecting....");
      socket?.connect();
      print("connected");
      print(socket);
      socket?.on('connect', (_) {
        print('connect: ${socket!.id}');
        setState(() {
          _connected = true;
        });
      });
      ScaffoldMessenger.of(context).showSnackBar(snackBarSuccess);
      socket?.on('press', (data) => handlePressure(data));
    } catch (e) {
      print(e.toString());
      ScaffoldMessenger.of(context).showSnackBar(snackBarFail);
    }
  }

  sendMessage(String topic, String message) {
    
    socket?.emit(
      topic,
      // {
      //   "id": socket!.id,
      //   "message": message, // Message to be sent
      //   "timestamp": DateTime.now().millisecondsSinceEpoch,
      // },
      message,
    );
  }

  void handlePressure(double data) {
    print(data);
    setState(() {
      pressureFromCloud = data.toStringAsFixed(3);
    });
  }

  ButtonStyle bStyle = ElevatedButton.styleFrom(
    backgroundColor: Colors.black,
    foregroundColor: Colors.white,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Arduino IOT Cloud"),
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: socket == null
                      ? () {
                          setState(() {
                            connectToServer();
                          });
                        }
                      : null,
                  style: bStyle,
                  child: const Text("connect"),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: _connected
                      ? () {
                          setState(() {
                            socket?.disconnect();
                            _connected = false;
                            socket = null;
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("You are disconnected !"),
                            ),
                          );
                        }
                      : null,
                  style: bStyle,
                  child: const Text("disconnect"),
                ),
              ),
            ],
          ),
          Expanded(
            child: GridView.count(
              primary: false,
              padding: const EdgeInsets.all(20),
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              crossAxisCount: 2,
              children: <Widget>[
                Container(
                    padding: const EdgeInsets.all(8),
                    color: Colors.teal[100],
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          "Pressure",
                          style: TextStyle(fontSize: 12),
                        ),
                        Expanded(
                          child: Center(
                            child: Text(
                              pressureFromCloud ?? "?",
                              style: const TextStyle(
                                  fontSize: 64, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    )),
                Container(
                  padding: const EdgeInsets.all(8),
                  color: Colors.teal[200],
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text(
                        "Led on desk",
                        style: TextStyle(fontSize: 12),
                      ),
                      Expanded(
                        child: Center(
                          child: SizedBox(
                            width: 80,
                            height: 40,
                            child: Switch(
                              value: _ledState,
                              onChanged: ((value) {
                                setState(() {
                                  _ledState = value;
                                  sendMessage("led1", value ? "on":"off");
                                });
                              }),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  color: Colors.teal[300],
                  child: const Text('Sound of screams but the'),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  color: Colors.teal[400],
                  child: const Text('Who scream'),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  color: Colors.teal[500],
                  child: const Text('Revolution is coming...'),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  color: Colors.teal[600],
                  child: const Text('Revolution, they...'),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
