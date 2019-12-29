import 'package:chatarrera_flutter/widgets/decorations.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:chatarrera_flutter/widgets/textfield_number.dart';
import 'package:chatarrera_flutter/widgets/dropdown.dart';
import 'package:chatarrera_flutter/services/firestore_materiales.dart';

class EntradasWidget extends StatefulWidget {
  @override
  _EntradasWidgetState createState() => _EntradasWidgetState();
}

class _EntradasWidgetState extends State<EntradasWidget>
    with AutomaticKeepAliveClientMixin {
  final dropDownFiltrosKey = UniqueKey();

  final dropDownMaterialesKey = GlobalKey<MyDropDownState>();
  final textFieldPrecioKey = UniqueKey();
  final textFieldKgKey = UniqueKey();
  final textFieldPagadoKey = UniqueKey();

  final dropDownClientesKey = UniqueKey();

  FocusNode textPrecioFocus = FocusNode();
  FocusNode textKgFocus = FocusNode();
  FocusNode textPagadoFocus = FocusNode();

  TextEditingController textPrecioController = new TextEditingController();
  TextEditingController textKgController = new TextEditingController();
  TextEditingController textPagadoController = new TextEditingController();

  int count = 0;

  List<String> clientes = <String>[
    'Fulanito',
    'Fulanita',
  ];
  List<String> filtros = <String>['Ascendente', 'Descendente', 'Material'];

  double padding = 5.0;
  double inputHeight = 45;

  DateTime valueDate = DateTime.now();

  //by default it will be null, change it to true.
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    entradasRows.add(entradasRow('Material', 'Kg', 'Precio', 'Pagado'));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Entradas"),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Column(
        children: <Widget>[
          barraArriba(),
          listViewEntradas(),
          datosParaEntradas()
        ],
      ),
    );
  }

// ===============================Barra superior========================
  Widget barraArriba() {
    return Container(
      child: Row(
        // mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Expanded(
            child: Container(
              // color: Colors.blueAccent,
              padding: EdgeInsets.all(padding),
              decoration: BoxDecoration(border: borderGris(rigth: true)),
              child: Row(
                children: <Widget>[
                  Container(
                    height: inputHeight,
                    decoration: decorationButtons(),
                    child: RaisedButton(
                      color: Theme.of(context).buttonColor,
                      onPressed: selectDate,
                      child: Text(DateFormat("dd/MM/yyyy").format(valueDate)),
                    ),
                  ),
                  SizedBox(
                    width: padding,
                  ),
                  MyDropDown(
                    hint: 'Filtro',
                    height: inputHeight,
                    items: filtros,
                    key: dropDownFiltrosKey,
                  )
                ],
              ),
            ),
          ),
          Container(
            height: inputHeight,
            margin: EdgeInsets.symmetric(horizontal: padding),
            decoration: decorationButtons(),
            child: RaisedButton(
              color: Theme.of(context).buttonColor,
              onPressed: () {},
              child: const Text('Resumen', style: TextStyle(fontSize: 16)),
            ),
          ),
        ],
      ),
    );
  }

  Future selectDate() async {
    DateTime picked = await showDatePicker(
      context: context,
      initialDate: new DateTime.now(),
      firstDate: new DateTime(2016),
      lastDate: new DateTime(2020),
    );
    if (picked != null) setState(() => valueDate = picked);
  }

// ==============================View de entradas=========================
  List<Widget> entradasRows = [];
  Widget listViewEntradas() {
    return Expanded(
      flex: 1,
      child: Container(
        decoration: BoxDecoration(border: borderGris(bottom: true, top: true)),
        // color: Colors.grey,
        child: ListView(children: entradasRows),
      ),
    );
  }

  Widget entradasRow(v1, v2, v3, v4) {
    return Container(
      decoration: BoxDecoration(border: borderGris(bottom: true)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(child: Center(child: Text(v1.toString()))),
          Expanded(child: Center(child: Text(v2.toString()))),
          Expanded(child: Center(child: Text(v3.toString()))),
          Expanded(child: Center(child: Text(v4.toString()))),
        ],
      ),
    );
  }

// ============================Inputs de entradas==========================
  Widget datosParaEntradas() {
    return Container(
      height: inputHeight * 2 + padding * 3,
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 17,
            child: Container(
              // color: Colors.indigo,
              decoration: BoxDecoration(border: borderGris(rigth: true)),
              padding: EdgeInsets.all(padding),
              child: Column(
                children: <Widget>[
                  inputsMaterialYPrecio(),
                  inputsKgYPagado(),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: clientesEIconos(),
          )
        ],
      ),
    );
  }

  Widget clientesEIconos() {
    return Container(
      // margin: EdgeInsets.all(padding),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(
            padding: EdgeInsets.all(0.0),
            icon: Icon(
              Icons.cancel,
              size: inputHeight,
              color: Colors.red,
            ),
            onPressed: limpiarInputs,
          ),
          IconButton(
            padding: EdgeInsets.all(0.0),
            icon: Icon(
              Icons.check,
              size: inputHeight,
              color: Colors.green,
            ),
            onPressed: registrarEntrada,
          )
        ],
      ),
    );
  }

  Widget inputsMaterialYPrecio() {
    return Container(
      padding: EdgeInsets.only(bottom: padding),
      child: Row(
        children: <Widget>[
          MyDropDown(
            height: inputHeight,
            items: FirestoreMateriales.materiales,
            hint: 'Material',
            key: dropDownMaterialesKey,
            nextFocus: this.textPrecioFocus,
            // margin: EdgeInsets.only(right: padding),
          ),
          SizedBox(width: padding), //Espacio entre objetos
          MyTextField(
            textInputType: TextInputType.number,
            controller: textPrecioController,
            key: this.textFieldPrecioKey,
            height: inputHeight,
            labelText: 'Precio',
            focusNode: this.textPrecioFocus,
            nextFocus: this.textKgFocus,
          )
        ],
      ),
    );
  }

  Widget inputsKgYPagado() {
    return Row(
      children: <Widget>[
        MyTextField(
          textInputType: TextInputType.number,
          controller: this.textKgController,
          key: this.textFieldKgKey,
          labelText: 'Kg',
          height: this.inputHeight,
          focusNode: this.textKgFocus,
          nextFocus: this.textPagadoFocus,
        ),
        SizedBox(width: padding), // Espacio entre inputs
        MyTextField(
          textInputType: TextInputType.number,
          controller: this.textPagadoController,
          key: this.textFieldPagadoKey,
          labelText: 'Pagado',
          height: this.inputHeight,
          focusNode: this.textPagadoFocus,
        )
      ],
    );
  }

  void registrarEntrada() {
    setState(() {
      this.entradasRows = List.from(this.entradasRows)
        ..add(
          entradasRow(
              this.dropDownMaterialesKey.currentState.valorActual,
              textKgController.text,
              textPrecioController.text,
              textPagadoController.text),
        );
    });
    print(entradasRows.length);
  }

  void limpiarInputs() {
    // TODO: Limpiar inputs de precio material etc
  }
}
