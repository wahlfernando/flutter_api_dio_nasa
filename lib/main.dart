import 'package:flutter/material.dart';
import 'package:flutter_app/ui/home.dart';
import 'package:flutter_app/ui/view_dados_nasa.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Nasa',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Home(),
      onGenerateRoute: (setings) {
        switch (setings.name) {
          case '/home':
            return MaterialPageRoute(builder: (_) => Home(),);
          case '/view_dados_nasa':
            return MaterialPageRoute(builder: (_) => ViewDadosNasa(),);
          case '/':
          default:
            return MaterialPageRoute(builder: (_) => Home());
        }
      },
    );
  }
}

