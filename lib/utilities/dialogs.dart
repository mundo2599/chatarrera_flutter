import 'package:flutter/material.dart';

void showWidgetDialog({
  @required BuildContext context,
  @required String titleText,
  @required Widget content,
}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      // return object of type Dialog
      return AlertDialog(
        contentPadding: EdgeInsets.all(0),
        title: Text(titleText),
        content: content,
        actions: <Widget>[
          // usually buttons at the bottom of the dialog
          new FlatButton(
            child: Text("Close"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

void showSimpleDialog({
  @required BuildContext context,
  @required String titleText,
  @required String contentText,
}) {
  showWidgetDialog(
    context: context,
    titleText: titleText,
    content: Text(contentText),
  );
}
