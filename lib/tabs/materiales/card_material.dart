import 'package:chatarrera_flutter/models/Material.dart';
import 'package:flutter/material.dart';

class CardMaterial extends StatefulWidget {
  final MaterialC material;

  CardMaterial({this.material});

  @override
  _CardMaterialState createState() => _CardMaterialState();
}

class _CardMaterialState extends State<CardMaterial> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: new EdgeInsets.all(5),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(7),
        ),
        color: Color.fromRGBO(245, 245, 245, 1),
        child: Center(
          child: Row(
            children: <Widget>[
              Text(widget.material.nombre),
              SizedBox(width: 10),
              Text(widget.material.precio.toString()),
              IconButton(
                icon: Icon(Icons.edit),
                tooltip: "Editar",
                onPressed: () {},
              ),
              IconButton(
                icon: Icon(Icons.delete_forever),
                tooltip: "Eliminar",
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
