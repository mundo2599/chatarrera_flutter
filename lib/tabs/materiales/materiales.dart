import 'package:chatarrera_flutter/models/Material.dart';
import 'package:chatarrera_flutter/services/firestore_materiales.dart';
import 'package:chatarrera_flutter/tabs/materiales/card_material.dart';
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

  List<MaterialC> materiales;

  String accionInputs = '';
  bool inputsVisibles = false;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: this.obtenerMateriales(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Column(
            children: <Widget>[
              treeViewMateriales(),
              inputs(),
            ],
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Widget treeViewMateriales() {
    return Expanded(
      child: Container(
        child: TreeView(
          parentList: materiales.map<Parent>(
            (materialPadre) {
              return Parent(
                parent: CardMaterial(
                  material: materialPadre,
                  isChild: false,
                  onPressAdd: this.onPressAddInMaterial,
                ),
                childList: ChildList(
                  children: materialPadre.hijos.map<Widget>(
                    (materialHijo) {
                      return Container(
                        margin: const EdgeInsets.only(left: 4.0),
                        child: CardMaterial(
                          material: materialHijo,
                          isChild: true,
                        ),
                      );
                    },
                  ).toList(),
                ),
              );
            },
          ).toList(),
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
    if (this.inputsVisibles)
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
            IconButton(
              icon: Icon(Icons.done),
              tooltip: "Aceptar",
              onPressed: onPressAceptar,
            ),
            IconButton(
              icon: Icon(Icons.cancel),
              tooltip: "Cancelar",
              onPressed: onPressCancelar,
              color: Colors.red,
            ),
          ],
        ),
      );
    else
      return Container();
  }

  void onPressAceptar() {
    MaterialC material = MaterialC();
    if (this.textNombreController.text != '') {
      material.nombre = this.textNombreController.text;
    } else {
      print('campo vacio');
      return;
    }
    try {
      material.precio = double.parse(this.textPrecioController.text);
    } catch (e) {
      print('formato de numero incorrecto');
      return;
    }

    FirestoreMateriales.addMaterial(material).then((_) {
      this.textNombreController.clear();
      this.textPrecioController.clear();
      setState(() {
        materiales.add(material);
      });
    });
  }

  void onPressCancelar() {
    setState(() {
      this.inputsVisibles = false;
    });
    this.textNombreController.clear();
    this.textPrecioController.clear();
  }

  Future<void> obtenerMateriales() async {
    if (materiales == null) {
      await FirestoreMateriales.getMateriales().then((materiales) {
        this.materiales = materiales;
      }).catchError((onError) {
        print('error al obtener materiales :C');
      });
    }
  }

  void onPressAddInMaterial(CardMaterial cardPresionado) {
    MaterialC materialPadre = cardPresionado.material;
    setState(() {
      this.inputsVisibles = true;
      this.accionInputs = 'Submaterial de ' + materialPadre.nombre;
    });
  }
}
