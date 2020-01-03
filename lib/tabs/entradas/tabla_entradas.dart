import 'package:chatarrera_flutter/models/Entrada.dart';
import 'package:flutter/material.dart';

enum Ordenamiento {
  NOMBRE,
  KG,
  PAGADO,
  PRECIO,
}

class TablaEntradas extends StatefulWidget {
  final List<Entrada> entradas;
  TablaEntradas({@required this.entradas});

  @override
  _TablaEntradasState createState() => _TablaEntradasState();
}

class _TablaEntradasState extends State<TablaEntradas> {
  bool sortAscending = true;
  int sortColumnIndex;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: DataTable(
        sortColumnIndex: sortColumnIndex,
        sortAscending: sortAscending,
        // horizontalMargin: 15,
        columnSpacing: 40,
        columns: [
          DataColumn(
            label: Text('Material'),
            onSort: (i, b) => ordenar(Ordenamiento.NOMBRE, i, b),
          ),
          DataColumn(
            label: Text('Kg'),
            onSort: (i, b) => ordenar(Ordenamiento.KG, i, b),
          ),
          DataColumn(
            label: Text('Precio'),
            onSort: (i, b) => ordenar(Ordenamiento.PRECIO, i, b),
          ),
          DataColumn(
            label: Text('Pagado'),
            onSort: (i, b) => ordenar(Ordenamiento.PAGADO, i, b),
          ),
        ],
        rows: widget.entradas.map<DataRow>(
          (entrada) {
            return DataRow(
              cells: [
                DataCell(Text(entrada.material.nombre)),
                DataCell(Text(entrada.kg.toString())),
                DataCell(Text(entrada.precio.toString())),
                DataCell(Text(entrada.pagado.toString())),
              ],
            );
          },
        ).toList(),
      ),
    );
  }

  void ordenar(Ordenamiento ordenamiento, int columna, bool ascendente) {
    sortAscending = ascendente;
    int sort = sortAscending ? 1 : -1;
    sortColumnIndex = columna;

    switch (ordenamiento) {
      case Ordenamiento.NOMBRE:
        widget.entradas.sort(
            (a, b) => a.material.nombre.compareTo(b.material.nombre) * sort);
        break;
      case Ordenamiento.KG:
        widget.entradas.sort((a, b) => a.kg.compareTo(b.kg) * sort);
        break;
      case Ordenamiento.PAGADO:
        widget.entradas.sort((a, b) => a.pagado.compareTo(b.pagado) * sort);
        break;
      case Ordenamiento.PRECIO:
        widget.entradas.sort((a, b) => a.precio.compareTo(b.precio) * sort);
        break;
    }

    setState(() {});
  }
}
