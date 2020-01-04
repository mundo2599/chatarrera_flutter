import 'package:flutter/material.dart';
import 'package:flutter_picker/flutter_picker.dart';

// Acomodar desbarajuste
Future<Map<String, DateTime>> showDateRangePicker(BuildContext context) {
  int radioValue = 0;

  // Picker para elegir el inicio del lapso el dia especifico
  Picker beginPicker = Picker(
    backgroundColor: Theme.of(context).dialogBackgroundColor,
    textStyle: Theme.of(context).textTheme.headline,
    hideHeader: true,
    adapter: DateTimePickerAdapter(type: PickerDateTimeType.kYMD),
  );

  // Picker para elegir fecha de fin, si se selecciona fecha este no se muestra
  Picker endPicker = Picker(
    backgroundColor: Theme.of(context).dialogBackgroundColor,
    textStyle: Theme.of(context).textTheme.headline,
    hideHeader: true,
    adapter: new DateTimePickerAdapter(type: PickerDateTimeType.kYMD),
  );

  // Botones de acciones de alertDialog
  List<Widget> actions = [
    FlatButton(
      onPressed: () {
        Navigator.pop(context);
      },
      child: new Text(PickerLocalizations.of(context).cancelText),
    ),
    FlatButton(
      onPressed: () {
        Map<String, DateTime> results = {
          'begin': (beginPicker.adapter as DateTimePickerAdapter).value,
          'end': (endPicker?.adapter as DateTimePickerAdapter)?.value,
        };
        Navigator.pop(context, results);
      },
      child: new Text(PickerLocalizations.of(context).confirmText),
    ),
  ];
  return showDialog<Map<String, DateTime>>(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
        builder: (context, setState) {
          //Row superior de radios para elegir entre dia o lapso de tiempo
          Row rowRadios = Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Radio(
                value: 0,
                groupValue: radioValue,
                onChanged: (value) => setState(() => radioValue = value),
              ),
              Text('Dia'),
              SizedBox(width: 20),
              Radio(
                value: 1,
                groupValue: radioValue,
                onChanged: (value) => setState(() => radioValue = value),
              ),
              Text('Lapso'),
            ],
          );

          // Content de Dialog
          Container content = Container(
            color: Theme.of(context).dialogBackgroundColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                rowRadios,
                Text(radioValue == 1 ? "Inicio" : "Fecha"),
                beginPicker.makePicker(),
                radioValue == 1 ? Text("Fin:") : Container(),
                radioValue == 1 ? endPicker?.makePicker() : Container(),
              ],
            ),
          );

          // Retornar alertDialog que se muestra
          return AlertDialog(
            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            title: Text("Select Date Range"),
            content: content,
            actions: actions,
          );
        },
      );
    },
  );
}
