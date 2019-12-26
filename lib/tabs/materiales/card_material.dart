import 'package:chatarrera_flutter/models/Material.dart';
import 'package:flutter/material.dart';

class CardMaterial extends StatefulWidget {
  final MaterialC material;
  final bool isParent;
  final void Function(CardMaterial) onPressDelete;
  final void Function(CardMaterial) onPressEdit;
  final void Function(CardMaterial) onPressAdd;

  CardMaterial({
    @required this.material,
    @required this.isParent,
    this.onPressDelete,
    this.onPressEdit,
    this.onPressAdd,
    Key key,
  }) : super(key: key);

  @override
  CardMaterialState createState() => CardMaterialState();
}

class CardMaterialState extends State<CardMaterial> {
  double pad = 7;
  double padTop;
  double iconSize = 30;

  bool isDesplegado = false;

  @override
  void initState() {
    padTop = widget.isParent ? pad : 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: pad, top: padTop, right: pad),
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(7),
        ),
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
      child: Row(
        children: <Widget>[
          InkResponse(
            onTap: () => widget.onPressAdd(this.widget),
            child: Icon(
              Icons.add,
              size: iconSize,
              color: widget.isParent ? Colors.black : Colors.white,
            ),
          ),
          InkResponse(
            onTap: () => widget.onPressEdit(this.widget),
            child: Icon(
              Icons.edit,
              size: iconSize,
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
            padding: EdgeInsets.only(left: 10),
            child: Icon(
              isDesplegado
                  ? Icons.keyboard_arrow_down
                  : Icons.keyboard_arrow_right,
              size: iconSize - iconSize / 4,
              color: widget.isParent ? Colors.black : Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  void onPress(bool isSelected) {
    setState(() {
      this.isDesplegado = !isSelected;
    });
  }

}
