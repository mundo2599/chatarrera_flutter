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

enum _MyState {
  creandoNuevo,
  creandoSub,
  editando,
  inputsOcultos,
}

class _MaterialesWidgetState extends State<MaterialesWidget> {
  double padding = 5.0;
  double inputHeight = 45;

  List<MaterialC> materiales;

  String textActionInputs;
  _MyState myState = _MyState.inputsOcultos;
  MaterialC materialPresionado;

  @override
  void initState() {
    this._obtenerMateriales();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Materiales"),
        backgroundColor: Colors.grey,
      ),
      body: body(),
    );
  }

  Widget body() {
    if (materiales != null) {
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
                  onPressEdit: this.onPressEditar,
                ),
                childList: ChildList(
                  children: materialPadre.hijos.map<Widget>(
                    (materialHijo) {
                      return Container(
                        margin: const EdgeInsets.only(left: 20.0),
                        child: CardMaterial(
                          material: materialHijo,
                          isChild: true,
                          onPressEdit: this.onPressEditar,
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
    if (this.myState != _MyState.inputsOcultos) {
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
              onPressed: _onPressAceptar,
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
    } else {
      return Container(
        margin: EdgeInsets.symmetric(vertical: padding),
        child: Center(
          child: InkResponse(
            onTap: this.onPressAddNewMaterial,
            child: Icon(
              Icons.add_circle_outline,
              size: 30,
            ),
          ),
        ),
      );
    }
  }

// ----------------------- FUNCIONES ------------------------------------------------------
  Future<void> _obtenerMateriales() async {
    await FirestoreMateriales.getMateriales().then((materiales) {
      setState(() => this.materiales = materiales);
    }).catchError((onError) {
      print('error al obtener materiales :C');
    });
  }

  void _onPressAceptar() {
    MaterialC materialNuevo = MaterialC();
    if (this.textNombreController.text != '') {
      materialNuevo.nombre = this.textNombreController.text;
    } else {
      print('campo vacio');
      return;
    }
    try {
      materialNuevo.precio = double.parse(this.textPrecioController.text);
    } catch (e) {
      print('formato de numero incorrecto');
      return;
    }

    switch (myState) {
      case _MyState.creandoNuevo:
        FirestoreMateriales.addMaterial(materialNuevo).then((_) {
          setState(() {
            this.materiales.add(materialNuevo);
          });
          this.changeMyState(_MyState.inputsOcultos);
        });
        break;
      case _MyState.creandoSub:
        materialNuevo.idPadre = this.materialPresionado.id;
        FirestoreMateriales.addMaterial(materialNuevo).then((_) {
          setState(() {
            this.materialPresionado.hijos.add(materialNuevo);
          });
          this.changeMyState(_MyState.inputsOcultos);
        });
        break;
      case _MyState.editando:
        materialPresionado.nombre = materialNuevo.nombre;
        materialPresionado.precio = materialNuevo.precio;
        FirestoreMateriales.updateMaterial(materialPresionado).then((_) {
          this.changeMyState(_MyState.inputsOcultos);
        });
        break;
      case _MyState.inputsOcultos:
        throw ('El estado de los inputs es oculto, por lo que no se debio haber llamado a aceptar');
        break;
    }
  }

  void changeMyState(_MyState state, [MaterialC materialPresionado]) {
    this.textNombreController.clear();
    this.textPrecioController.clear();
    setState(() {
      this.myState = state;
      this.materialPresionado = materialPresionado;
    });
  }

  void onPressEditar(CardMaterial cardPresionado) {
    this.changeMyState(_MyState.editando, cardPresionado.material);
    this.textNombreController.text = this.materialPresionado.nombre;
    this.textPrecioController.text = this.materialPresionado.precio.toString();
  }

  void onPressAddNewMaterial() {
    this.changeMyState(_MyState.creandoNuevo);
  }

  void onPressAddInMaterial(CardMaterial cardPresionado) {
    this.changeMyState(_MyState.creandoSub, cardPresionado.material);
  }

  void onPressCancelar() {
    this.changeMyState(_MyState.inputsOcultos);
  }

  void onPressDelete() {
    // TODO: terminar delete
  }

}
