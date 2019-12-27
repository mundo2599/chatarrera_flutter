import 'package:flutter/material.dart';

void showSimpleDialog({
  @required BuildContext context,
  @required String titleText,
  @required String contentText,
}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      // return object of type Dialog
      return AlertDialog(
        title: new Text(titleText),
        content: new Text(contentText),
        actions: <Widget>[
          // usually buttons at the bottom of the dialog
          new FlatButton(
            child: new Text("Close"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
