import 'package:flutter/material.dart';

class ContainerWithTitle extends StatelessWidget {
  final String title;
  final Widget child;

  final Decoration decoration;
  final EdgeInsetsGeometry padding;

  ContainerWithTitle({
    @required this.title,
    @required this.child,
    this.decoration,
    this.padding,
  });

  final double titleSize = 13;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: <Widget>[
          SafeArea(
            child: Container(
              padding: EdgeInsets.only(top: titleSize / 2),
              child: Container(
                padding: EdgeInsets.only(top: titleSize, bottom: titleSize / 2),
                decoration: this.decoration,
                child: Container(
                  // padding: this.padding,
                  child: this.child,
                ),
              ),
            ),
          ),
          Positioned(
            top: 0.0,
            left: 20.0,
            child: Container(
              color: Theme.of(context).scaffoldBackgroundColor,
              child: Text(
                this.title,
                style: TextStyle(fontSize: this.titleSize),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
