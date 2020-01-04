import 'package:chatarrera_flutter/models/Entrada.dart';
import 'package:chatarrera_flutter/models/Material.dart';
import 'package:chatarrera_flutter/services/firestore_entradas.dart';
import 'package:chatarrera_flutter/tabs/entradas/tabla_entradas.dart';
import 'package:chatarrera_flutter/utilities/date_range_picker.dart';
import 'package:chatarrera_flutter/utilities/dialogs.dart';
import 'package:chatarrera_flutter/utilities/decorations.dart';
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

  final dropDownMaterialesKey = GlobalKey<MyDropDownState<MaterialC>>();
  final textFieldPrecioKey = UniqueKey();
  final textFieldKgKey = UniqueKey();
  final textFieldPagadoKey = UniqueKey();

  FocusNode textPrecioFocus = FocusNode();
  FocusNode textKgFocus = FocusNode();
  FocusNode textPagadoFocus = FocusNode();

  TextEditingController textPrecioController = new TextEditingController();
  TextEditingController textKgController = new TextEditingController();
  TextEditingController textPagadoController = new TextEditingController();

  int count = 0;

  double padding = 10.0;
  double inputHeight = 45;
  double bordersWidth = 2;

  DateTime beginDate = DateTime.now(), endDate;

  //by default it will be null, change it to true.
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    obtenerEntradas();
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
      height: inputHeight,
      padding: EdgeInsets.symmetric(horizontal: padding),
      decoration: BoxDecoration(
        border: borderGris(bottom: true, width: bordersWidth),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          // Seleccionar lapso de fecha
          Expanded(
            child: InkResponse(
              onTap: selectDate,
              child: Container(
                height: inputHeight,
                decoration: BoxDecoration(
                  border: borderGris(rigth: true, width: bordersWidth),
                ),
                margin: EdgeInsets.only(right: padding),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.date_range,
                      size: inputHeight / 1.5,
                    ),

                    SizedBox(width: padding * 2),
                    
                    Text(textoFecha()),
                  ],
                ),
              ),
            ),
          ),
          // Boton para ver resumen
          Center(
            child: RaisedButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(7),
              ),
              onPressed: onPressResumen,
              child: Text('Resumen'),
            ),
          ),
        ],
      ),
    );
  }

  void selectDate() {
    showDateRangePicker(context).then((fechas) {
      if (fechas != null) {
        setState(() {
          beginDate = fechas['begin'];
          endDate = fechas['end'];
        });
        obtenerEntradas();
      }
    });
  }

  String textoFecha() {
    String textoFecha = DateFormat("dd/MM/yyyy").format(beginDate);
    if (endDate != null)
      textoFecha += ' - ' + DateFormat("dd/MM/yyyy").format(endDate);
    return textoFecha;
  }

// ==============================View de entradas=========================
  List<Entrada> entradas;
  Widget listViewEntradas() {
    // Si se estan cargando las entradas, mostrar un indicador circular de progreso
    if (entradas == null) {
      return Expanded(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      return Expanded(
        child: TablaEntradas(
          entradas: entradas,
        ),
      );
    }
  }

// ============================Inputs de entradas==========================
  Widget datosParaEntradas() {
    return Container(
      decoration: BoxDecoration(
        border: borderGris(top: true, bottom: true, width: bordersWidth),
      ),
      height: inputHeight * 2 + padding * 3 + bordersWidth * 2,
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 17,
            child: Container(
              // color: Colors.indigo,
              decoration: BoxDecoration(
                border: borderGris(rigth: true, width: bordersWidth),
              ),
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
          MyDropDown<MaterialC>(
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
    bool error = false;

    Entrada entrada = Entrada();
    entrada.fecha = beginDate;
    entrada.material = this.dropDownMaterialesKey.currentState.valorActual;
    if (entrada.material == null) error = true;

    try {
      entrada.kg = double.parse(textKgController.text);
      entrada.pagado = double.parse(textPagadoController.text);
    } catch (e) {
      error = true;
    }

    if (!error) {
      FirestoreEntradas.addEntrada(entrada).then(
        (_) {
          limpiarInputs();
          setState(() => this.entradas.add(entrada));
        },
        onError: (e) => error = true,
      );
    }

    if (error) {
      showSimpleDialog(
        context: context,
        titleText: "Error",
        contentText: "Hay un error en los datos de la entrada",
      );
    }
  }

  void limpiarInputs() {
    FocusScope.of(context).unfocus();
    this.dropDownMaterialesKey.currentState.clearSelect();
    this.textKgController.clear();
    this.textPagadoController.clear();
    this.textPrecioController.clear();
  }

  void obtenerEntradas() {
    setState(() => entradas = null);
    FirestoreEntradas.getEntradas(
      fechaInicio: this.beginDate,
      fechaFin: this.endDate,
    ).then((entradas) {
      setState(() {
        this.entradas = entradas;
      });
    });
  }

  void onPressResumen() {
    Map<MaterialC, Entrada> resumenMap = <MaterialC, Entrada>{};
    for (MaterialC material in FirestoreMateriales.materiales)
      resumenMap[material] = Entrada(material: material);

    for (Entrada entrada in entradas) resumenMap[entrada.material] += entrada;

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(
              title: Text(textoFecha()),
            ),
            body: Center(
              heightFactor: 1,
              child: TablaEntradas(entradas: resumenMap.values.toList()),
            ),
          );
        },
      ),
    );
  }
}
