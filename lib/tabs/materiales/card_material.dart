import 'package:chatarrera_flutter/models/Material.dart';
import 'package:flutter/material.dart';

class CardMaterial extends StatefulWidget {
  final MaterialC material;
  final bool isChild;
  final void Function(CardMaterial) onPressDelete;
  final void Function(CardMaterial) onPressEdit;
  final void Function(CardMaterial) onPressAdd;

  CardMaterial({
    this.material,
    this.isChild = false,
    this.onPressDelete,
    this.onPressEdit,
    this.onPressAdd,
  });

  @override
  _CardMaterialState createState() => _CardMaterialState();
}

class _CardMaterialState extends State<CardMaterial> {
  double pad = 5;
  double iconSize = 30;

  bool isDesplegado = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: pad, top: pad, right: pad),
      // padding: EdgeInsets.only(pad),
      // color: Colors.red,
      child: Card(
        // margin: EdgeInsets.all(pad),
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(7),
          // side: BorderSide(color: Color.fromRGBO(245, 245, 245, 1)),
        ),
        // color: Color.fromRGBO(245, 245, 245, 1),
        child: Container(
          padding: EdgeInsets.all(pad),
          child: Row(
            children: <Widget>[
              nombreYPrecio(),
              iconos(),
            ],
          ),
        ),
      ),
    );
  }

  Widget nombreYPrecio() {
    return Expanded(
      child: Row(
        children: <Widget>[
          Expanded(
            // flex: 8,
            child: Text(
              widget.material.nombre,
              style: TextStyle(fontSize: 20),
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            // flex: 14,
            child: Text(
              widget.material.precio.toString(),
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }

  Widget iconos() {
    return Container(
      // color: Colors.amber,
      child: Row(
        // direction: Axis.horizontal,
        children: <Widget>[
          InkResponse(
            onTap: () => widget.onPressEdit(this.widget),
            child: Icon(
              Icons.edit,
              size: iconSize,
              // color: Colors.black,
            ),
          ),
          InkResponse(
            onTap: () => widget.onPressAdd(this.widget),
            child: Icon(
              Icons.add,
              size: iconSize,
              // color: Colors.black,
            ),
          ),
          InkResponse(
            onTap: () => widget.onPressDelete(this.widget),
            child: Icon(
              Icons.delete_forever,
              size: iconSize,
              color: Colors.red,
            ),
          ),
          Container(
            // color: Colors.red,
            padding: EdgeInsets.only(left: 10),
            child: Icon(
              isDesplegado
                  ? Icons.keyboard_arrow_down
                  : Icons.keyboard_arrow_right,
              size: iconSize - iconSize / 4,
              color: widget.isChild ? Colors.white : Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
