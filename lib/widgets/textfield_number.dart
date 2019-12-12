import 'package:flutter/material.dart';

class MyTextField extends StatefulWidget {

  final double height;
  final String labelText;
  final FocusNode focusNode;
  final FocusNode nextFocus;
  final TextEditingController controller;
  final TextInputType textInputType;

  MyTextField({
    Key key,
    this.height,
    this.labelText,
    this.focusNode,
    this.nextFocus,
    this.controller,
    this.textInputType,
  }) : super(key: key);

  @override
  _MyTextFieldState createState() => new _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  @override
  Widget build(BuildContext context) {
    return Flexible( 
      child: Container(
        height: widget.height,
        child: TextField(
          controller: widget.controller,
          focusNode: widget.focusNode,
          keyboardType: widget.textInputType,
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