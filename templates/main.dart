import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatefulWidget {
  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      onGenerateRoute: (settings) {
        return null;
      },
      routes: {
        '/' : (context) => StartView(),
      },
    );
  }
}

class StartView extends StatelessWidget {
    
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(child: Text('Hello Wold!'),),
    );
  }
}
