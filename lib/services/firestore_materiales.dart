import 'dart:async';
// import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:chatarrera_flutter/models/Material.dart';
import 'package:chatarrera_flutter/services/firestore_collections.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreMateriales {
  static CollectionReference materialesRef = FirestoreCollections.materiales;

  static Future<void> addMaterial(MaterialC material) async {
    return materialesRef.add(material.toMap());
  }

  static Future<void> updateMaterial(MaterialC material) async {
    return materialesRef.document(material.id).updateData(material.toMap());
  }

  static Future<List<MaterialC>> getMateriales() async {
    List<MaterialC> materialesPadres = <MaterialC>[];
    List<MaterialC> materialesHijos = <MaterialC>[];

    return materialesRef.orderBy("nombre").getDocuments().then<List<MaterialC>>(
      (results) {
        for (var document in results.documents) {
          MaterialC material =
              MaterialC.fromMap(document.data, document.documentID);
          if (material.idPadre == null)
            materialesPadres.add(material);
          else
            materialesHijos.add(material);
        }

        if (materialesHijos.length != 0) {
          for (var materialPadre in materialesPadres) {
            Iterable<MaterialC> hijos = materialesHijos.where(
              (materialHijo) => materialHijo.idPadre == materialPadre.id,
            );
            materialPadre.hijos.addAll(hijos);
          }
        }

        return materialesPadres;
      },
    );
  }
}
