import 'package:flutter/material.dart';

class MyDropDown<T> extends StatefulWidget {
  final List<T> items;
  final EdgeInsets margin;
  final double height;
  final String hint;
  final FocusNode nextFocus;

  MyDropDown(
      {Key key,
      this.items,
      this.margin,
      this.height,
      this.hint,
      this.nextFocus})
      : super(key: key);

  @override
  MyDropDownState<T> createState() => new MyDropDownState<T>();
}

class MyDropDownState<T> extends State<MyDropDown> {
  T valorActual;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
        padding: EdgeInsets.only(left: 6),
        margin: widget.margin,
        height: widget.height,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.all(Radius.circular(4.0)),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton<T>(
            hint: Text(widget.hint),
            isExpanded: true,
            value: valorActual,
            onChanged: (T newValue) {
              if (widget.nextFocus != null)
                FocusScope.of(context).requestFocus(widget.nextFocus);
              setState(() {
                valorActual = newValue;
              });
            },
            items: widget.items.map<DropdownMenuItem<T>>(
              (dynamic value) {
                return DropdownMenuItem<T>(
                  value: value,
                  child: Text(value.toString()),
                );
              },
            ).toList(),
          ),
        ),
      ),
    );
  }

  void clearSelect() {
    setState(() {
      valorActual = null;
    });
  }

}
