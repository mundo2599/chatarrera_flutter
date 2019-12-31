import 'package:chatarrera_flutter/models/Entrada.dart';
import 'package:chatarrera_flutter/services/firestore_collections.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreEntradas {
  static CollectionReference entradasRef = FirestoreCollections.entradas;

  /// Agrega la entrada por parametro a firebase y le asigna a la instacia el id,
  /// esa misma instancia que es pasada por parametro es retornada
  static Future<Entrada> addEntrada(Entrada entrada) {
    return entradasRef.add(entrada.toMap()).then<Entrada>(
      (reference) {
        entrada.id = reference.documentID;
        return entrada;
      },
    );
  }

  /// Regresa las entradas de un dia determinado si solo se proporciona la fecha
  /// de inicio, o se proporcionan las entradas de un lapso de tiempo si se
  /// proporciona tambien la fecha de fin
  static Future<List<Entrada>> getEntradas({
    DateTime fechaInicio,
    DateTime fechaFin,
  }) {

    if(fechaFin == null) {
      fechaFin = fechaInicio.add(Duration(days: 1));
      fechaFin = DateTime(fechaFin.year, fechaFin.month, fechaFin.day);
    }

    Query query = entradasRef;
    query = query.where(
      "fecha",
      isGreaterThanOrEqualTo: fechaInicio.toString(),
      isLessThan: fechaFin.toString(),
    );

    return query.getDocuments().then<List<Entrada>>(
      (snapshot) {
        return snapshot.documents.map<Entrada>((snapshot) {
          return Entrada.fromMap(snapshot.data, snapshot.documentID);
        }).toList();
      },
    );
  }

  static Future<void> updateEntrada(Entrada entrada) {
    return entradasRef.document(entrada.id).updateData(entrada.toMap());
  }

  static Future<void> deleteMaterial(String id) {
    if (id == null && id == '') throw ('Se requiere un id para eliminar');
    return entradasRef.document(id).delete();
  }
}
