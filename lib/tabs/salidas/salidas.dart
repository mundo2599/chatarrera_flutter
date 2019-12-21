import 'package:flutter/material.dart';

class SalidasWidget extends StatefulWidget {
  @override
  _SalidasWidgetState createState() => _SalidasWidgetState();
}

class _SalidasWidgetState extends State<SalidasWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Salidas"),
        backgroundColor: Colors.grey,
      ),
      body: Container(
        child: Center(child: Text('Salidas')),
      ),
    );
  }
}
