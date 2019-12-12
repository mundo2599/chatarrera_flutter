import 'dart:async';
// import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:chatarrera_flutter/models/Material.dart';
import 'package:chatarrera_flutter/services/firestore_collections.dart';

class FirestoreMaterialesService {
  Future<List<MaterialC>> getMateriales() async {
    var completer = new Completer<List<MaterialC>>();
    await FirestoreCollections.materiales.orderBy("nombre").getDocuments().then(
      (results) {
        completer.complete(
          results.documents
              .map((value) => MaterialC.fromMap(value.data))
              .toList(),
        );
      },
    );

    return completer.future;
  }
}
