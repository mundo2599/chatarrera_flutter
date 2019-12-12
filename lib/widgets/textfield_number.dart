import 'package:flutter/material.dart';

class MyTextFieldNumber extends StatefulWidget {

  final double height;
  final String labelText;
  final FocusNode focusNode;
  final FocusNode nextFocus;
  final TextEditingController controller;

  MyTextFieldNumber({
    Key key,
    this.height,
    this.labelText,
    this.focusNode,
    this.nextFocus,
    this.controller
  }) : super(key: key);

  @override
  MyTextFieldNumberState createState() => new MyTextFieldNumberState();
}

class MyTextFieldNumberState extends State<MyTextFieldNumber> {
  @override
  Widget build(BuildContext context) {
    return Flexible( 
      child: Container(
        height: widget.height,
        child: TextField(
          controller: widget.controller,
          focusNode: widget.focusNode,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: widget.labelText,
          ),
          onSubmitted: (term) {
            FocusScope.of(context).requestFocus(widget.nextFocus);
          },
        )
      )
    );
  }
}