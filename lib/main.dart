// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, deprecated_member_use

import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(TestStream());
}

StreamController<String> streamController = StreamController();

class TestStream extends StatefulWidget {
  @override
  _TestStreamState createState() => _TestStreamState();
}

class _TestStreamState extends State<TestStream> {
  late Stream<String> myStream;
  @override
  void initState() {
    super.initState();
    myStream = streamController.stream;
    Timer(Duration(microseconds: 3000), () {
      streamController.sink.add("First value");
    });
    Timer(Duration(microseconds: 5000), () {
      streamController.sink.add("Next value");
    });
  }

  @override
  void dispose() {
    streamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Try Asynchronous"),
        ),
        body: Center(
          child: StreamBuilder<String>(
            stream: myStream,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.active) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      snapshot.data.toString(),
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(height: 30),
                    RaisedButton(
                        child: Text("Add Stream"),
                        onPressed: () {
                          DateTime date = DateTime.now();
                          streamController.sink.add(date.toIso8601String());
                        })
                  ],
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      title: "Try Asynchronous",
    );
  }
}
