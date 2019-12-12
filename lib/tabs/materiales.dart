import 'package:chatarrera_flutter/widgets/decorations.dart';
import 'package:chatarrera_flutter/widgets/textfield_number.dart';
import 'package:flutter/material.dart';
import 'package:tree_view/tree_view.dart';

class MaterialesWidget extends StatefulWidget {
  @override
  _MaterialesWidgetState createState() => _MaterialesWidgetState();
}

class _MaterialesWidgetState extends State<MaterialesWidget> {
  double padding = 5.0;
  double inputHeight = 45;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        treeViewMateriales(),
        inputs(),
      ],
    );
  }

  Widget treeViewMateriales() {
    return Expanded(
      child: Container(
        child: TreeView(
          parentList: [],
        ),
      ),
    );
  }

  final textFieldNombreKey = UniqueKey();
  final textFieldPrecioKey = UniqueKey();
  FocusNode textNombreFocus = FocusNode();
  FocusNode textPrecioFocus = FocusNode();
  TextEditingController textNombreController = new TextEditingController();
  TextEditingController textPrecioController = new TextEditingController();
  Widget inputs() {
    return Container(
      decoration: BoxDecoration(border: borderGris(top: true, bottom: true)),
      padding: EdgeInsets.all(padding),
      child: Row(
        children: <Widget>[
          MyTextField(
            textInputType: TextInputType.text,
            controller: this.textNombreController,
            key: this.textFieldNombreKey,
            labelText: 'Nombre',
            height: inputHeight,
            focusNode: this.textNombreFocus,
            nextFocus: this.textPrecioFocus,
          ),
          SizedBox(width: padding), // Espacio entre inputs
          MyTextField(
            textInputType: TextInputType.number,
            controller: this.textPrecioController,
            key: this.textFieldPrecioKey,
            labelText: 'Precio',
            height: inputHeight,
            focusNode: this.textPrecioFocus,
            // nextFocus: this.textPagadoFocus,
          ),
        ],
      ),
    );
  }
}
