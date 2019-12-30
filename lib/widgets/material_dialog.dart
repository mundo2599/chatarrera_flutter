import 'package:flutter/material.dart';

showMaterialDialog(BuildContext context) {
  showDialog<void>(
    context: context,
    builder: (BuildContext context) {
      int selectedRadio = 0;
      return AlertDialog(
        content: StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: List<Widget>.generate(4, (int index) {
                return Radio<int>(
                  value: index,
                  groupValue: selectedRadio,
                  onChanged: (int value) {
                    setState(() => selectedRadio = value);
                  },
                );
              }),
            );
          },
        ),
      );
    },
  );
}

const PickerData = '''
[
    "Aluminio",
    "Chatarra"
]
    ''';
