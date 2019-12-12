import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreCollections {
  static final Firestore instance = Firestore.instance;
  static final CollectionReference materiales = instance.collection('materiales');
  static final CollectionReference entradas = instance.collection('entradas');
  static final CollectionReference salidas = instance.collection('salidas');
}
