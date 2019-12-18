import 'dart:async';
// import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:chatarrera_flutter/models/Material.dart';
import 'package:chatarrera_flutter/services/firestore_collections.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreMateriales {
  static CollectionReference materialesRef = FirestoreCollections.materiales;

  // TODO: Que es lo mas conveniente regresar en metodos?

  static Future<void> addMaterial(MaterialC material) async {
    return materialesRef.add(material.toMap());
  }

  static Future<void> updateMaterial(MaterialC material) async {
    return materialesRef.document(material.id).updateData(material.toMap());
  }

  static Future<List<MaterialC>> getMateriales() async {
    var completer = new Completer<List<MaterialC>>();
    await materialesRef.orderBy("nombre").getDocuments().then(
      (results) {
        completer.complete(
          results.documents
              .map(
                (value) => MaterialC.fromMap(value.data, value.documentID),
              )
              .toList(),
        );
      },
    );

    return completer.future;
  }
}
