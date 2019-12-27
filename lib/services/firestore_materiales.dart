import 'dart:async';

import 'package:chatarrera_flutter/models/Material.dart';
import 'package:chatarrera_flutter/services/firestore_collections.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreMateriales {
  static CollectionReference materialesRef = FirestoreCollections.materiales;

  // Lista local de materiales usada en distintas vistas
  static List<MaterialC> materiales;

  static Future<void> addMaterial(MaterialC material) {
    // Agregar a la base de datos
    return _addMaterial(material).then((_) {
      // Agregar a la lista de materiales local
      materiales.add(material);
    }, onError: (error) {
      print('Error al agregar :C');
    });
  }

  static Future<void> addSubMaterial({MaterialC padre, MaterialC hijo}) {
    hijo.idPadre = padre.id;
    // Agregar material a base de datos
    return _addMaterial(hijo).then((_) {
      // Agregar material a la listo de hijos del padre
      padre.hijos.add(hijo);
    });
  }

  static Future<void> obtenerMateriales() {
    return _getMateriales().then((materiales) {
      // Asignar materiales de base de datos a lista local
      FirestoreMateriales.materiales = materiales;
    }).catchError((onError) {
      throw('error al obtener materiales :C');
    });
  }

  static Future<void> deleteMaterial(MaterialC material) {
    return _deleteMaterial(material.id).then((_) {
      materiales.remove(material);
    });
  }


  /// Agregar un nuevo material a Firebase
  static Future<void> _addMaterial(MaterialC material) {
    return materialesRef.add(material.toMap()).then<void>((reference) {
      // Asignar el id al material
      material.id = reference.documentID;
    });
  }

  static Future<void> updateMaterial(MaterialC material) {
    return materialesRef.document(material.id).updateData(material.toMap());
  }

  static Future<List<MaterialC>> _getMateriales() {
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

  static Future<void> _deleteMaterial(String id) {
    if(id == null && id == '')
      throw('Se requiere un id para eliminar');
    return materialesRef.document(id).delete();
  }
}
